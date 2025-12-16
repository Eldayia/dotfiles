#!/bin/sh

# Arrêter le script si une commande échoue
set -e

echo "============================================"
echo "   PRÉPARATION INSTALLATION NIXOS (UEFI)    "
echo "============================================"

# --- 1. CLAVIER ---
echo ""
echo "[1/4] Configuration du clavier en Français..."
loadkeys fr
echo "Clavier passé en AZERTY."

# --- 2. WIFI ---
echo ""
echo "[2/4] Configuration du Wi-Fi..."
read -p "Voulez-vous configurer le Wi-Fi ? (o/n) : " ASK_WIFI

if [ "$ASK_WIFI" = "o" ] || [ "$ASK_WIFI" = "O" ] || [ "$ASK_WIFI" = "y" ] || [ "$ASK_WIFI" = "Y" ]; then
    echo "Liste des interfaces :"
    ip link | grep -E '^[0-9]+: ' | cut -d: -f2 | grep -v "lo"
    echo ""

    read -p "Entrez le nom de l'interface WiFi (ex: wlan0) : " WIFI_INTERFACE
    read -p "Entrez le nom du SSID (Nom du WiFi) : " WIFI_SSID
    read -s -p "Entrez le mot de passe WiFi : " WIFI_PASS
    echo ""

    echo "Connexion en cours..."
    wpa_passphrase "$WIFI_SSID" "$WIFI_PASS" > /etc/wpa_supplicant.conf
    wpa_supplicant -B -i "$WIFI_INTERFACE" -c /etc/wpa_supplicant.conf

    echo "Attente de la connexion (5 secondes)..."
    sleep 5
    if ping -c 1 google.com > /dev/null 2>&1; then
        echo "✅ Connecté à Internet !"
    else
        echo "⚠️ Pas de connexion détectée. Vérifiez le mot de passe."
        read -p "Appuyez sur Entrée pour continuer quand même ou Ctrl+C pour arrêter..."
    fi
else
    echo "⏭️  Configuration Wi-Fi ignorée."
fi

# --- 3. DISQUE & FORMATAGE ---
echo ""
echo "[3/4] Formatage du disque"
echo "Disques disponibles :"
lsblk -d -n -o NAME,SIZE,MODEL

echo ""
read -p "Quel disque voulez-vous formater ? (ex: nvme0n1 ou sda) : " DISK_NAME
TARGET_DISK="/dev/$DISK_NAME"

# Vérification de sécurité
echo ""
echo "ATTENTION : TOUTES LES DONNÉES SUR $TARGET_DISK SERONT EFFACÉES !"
read -p "Êtes-vous sûr ? (écrivez 'oui') : " CONFIRM
if [ "$CONFIRM" != "oui" ]; then
    echo "Annulation."
    exit 1
fi

# Logique pour nommage des partitions
if echo "$DISK_NAME" | grep -qE "[0-9]$"; then
    PART_PREFIX="${DISK_NAME}p"  # nvme0n1 -> nvme0n1p
else
    PART_PREFIX="${DISK_NAME}"   # sda -> sda
fi

echo "Création de la table de partition GPT..."
parted -s "$TARGET_DISK" -- mklabel gpt

echo "Création des partitions..."
# Partition 1 : ESP (boot) - 512 MB
parted -s "$TARGET_DISK" -- mkpart ESP fat32 1MiB 513MiB
parted -s "$TARGET_DISK" -- set 1 esp on

# Partition 2 : Root - Tout le reste de l'espace disponible
parted -s "$TARGET_DISK" -- mkpart primary ext4 513MiB 100%

echo "Table de partition créée :"
parted "$TARGET_DISK" print

# On force le système à relire la table des partitions
partprobe "$TARGET_DISK" 2>/dev/null || true
sleep 2

echo ""
echo "Formatage des partitions..."
echo "  - Formatage de /dev/${PART_PREFIX}1 en FAT32 (boot)..."
mkfs.fat -F 32 -n boot "/dev/${PART_PREFIX}1"

echo "  - Formatage de /dev/${PART_PREFIX}2 en ext4 (nixos)..."
mkfs.ext4 -F -L nixos "/dev/${PART_PREFIX}2"

echo ""
echo "Montage des partitions..."
mount "/dev/${PART_PREFIX}2" /mnt
mkdir -p /mnt/boot
mount "/dev/${PART_PREFIX}1" /mnt/boot

echo "✅ Partitions montées :"
lsblk "$TARGET_DISK"
df -h | grep -E "(Mounted|/mnt)"
echo ""

# --- 4. GÉNÉRATION CONFIGURATION MATÉRIELLE ---
echo ""
echo "[4/6] Génération de la configuration de base..."
nixos-generate-config --root /mnt
echo "✅ Configuration matérielle générée dans /mnt/etc/nixos/"

# --- 5. COPIE DES DOTFILES ---
echo ""
echo "[5/6] Récupération de vos fichiers de configuration..."

# On demande le lien du repo (ou dossier local)
read -p "URL du dépôt Git (défaut: https://github.com/Eldayia/dotfiles.git) : " GIT_REPO
GIT_REPO=${GIT_REPO:-"https://github.com/Eldayia/dotfiles.git"}

read -p "Branche à cloner (défaut: nixos) : " GIT_BRANCH
GIT_BRANCH=${GIT_BRANCH:-"nixos"}

if [ -n "$GIT_REPO" ]; then
    echo "Clonage du dépôt (branche: $GIT_BRANCH)..."
    # On installe git temporairement s'il n'est pas là
    nix-env -iA nixos.git 2>/dev/null || echo "Git déjà installé"

    # On clone dans un dossier temporaire avec la branche choisie
    git clone -b "$GIT_BRANCH" "$GIT_REPO" /mnt/tmp/dotfiles

    # Sauvegarder hardware-configuration.nix
    cp /mnt/etc/nixos/hardware-configuration.nix /mnt/tmp/hardware-backup.nix

    echo "Copie des fichiers vers /mnt/etc/nixos..."
    cp -r /mnt/tmp/dotfiles/nixos/* /mnt/etc/nixos/

    # Restaurer hardware-configuration.nix
    cp /mnt/tmp/hardware-backup.nix /mnt/etc/nixos/hardware-configuration.nix

    # On supprime le dossier temporaire
    rm -rf /mnt/tmp/dotfiles
    rm /mnt/tmp/hardware-backup.nix

    echo "✅ Configuration importée depuis Git !"
else
    echo "⚠️  Aucun dépôt fourni. Vous devrez éditer configuration.nix manuellement."
fi

# Vérification finale
if [ ! -f /mnt/etc/nixos/hardware-configuration.nix ]; then
    echo "❌ ERREUR : hardware-configuration.nix manquant !"
    nixos-generate-config --root /mnt
fi

# --- 6. AFFICHAGE INFORMATIONS ---
echo ""
echo "[6/6] Vérification finale..."
echo ""
echo "Contenu de /mnt/etc/nixos/ :"
ls -lah /mnt/etc/nixos/

echo ""
echo "============================================"
echo "✅ TERMINÉ !"
echo "Vérifiez vos fichiers avant d'installer :"
echo "ls -la /mnt/etc/nixos/"
echo "Puis lancez : nixos-install"
echo "============================================"