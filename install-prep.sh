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
parted -s "$TARGET_DISK" -- mkpart ESP fat32 1MB 512MB
parted -s "$TARGET_DISK" -- set 1 esp on
parted -s "$TARGET_DISK" -- mkpart primary 512MB 100%

# On force le système à relire la table des partitions
partprobe "$TARGET_DISK" 2>/dev/null || true
sleep 2

echo "Formatage des partitions..."
mkfs.fat -F 32 -n boot "/dev/${PART_PREFIX}1"
mkfs.ext4 -L nixos "/dev/${PART_PREFIX}2"

echo "Montage des partitions..."
# CORRECTION ICI : On utilise le chemin direct au lieu du label pour éviter l'erreur
mount "/dev/${PART_PREFIX}2" /mnt
mkdir -p /mnt/boot
mount "/dev/${PART_PREFIX}1" /mnt/boot

#!/bin/sh
set -e

# --- 4. GÉNÉRATION CONFIGURATION MATÉRIELLE ---
echo ""
echo "[4/5] Génération de la configuration de base..."
nixos-generate-config --root /mnt

# --- 5. COPIE DES DOTFILES ---
echo ""
echo "[5/5] Récupération de vos fichiers de configuration..."

# On demande le lien du repo (ou dossier local)
read -p "Avez-vous un dépôt Git pour vos dotfiles ? (Laissez vide si non) : " GIT_REPO

if [ -n "$GIT_REPO" ]; then
    echo "Clonage du dépôt..."
    # On installe git temporairement s'il n'est pas là
    nix-env -iA nixos.git
    
    # On clone dans un dossier temporaire
    git clone "$GIT_REPO" /mnt/tmp/dotfiles
    
    echo "Copie des fichiers vers /mnt/etc/nixos..."
    # On copie tout le contenu du dossier 'nixos' du repo vers la destination
    # ATTENTION : Adaptez le chemin '/mnt/tmp/dotfiles/nixos/*' si votre structure est différente
    sudo cp -r /mnt/tmp/dotfiles/nixos/* /mnt/etc/nixos/
    
    # On supprime le dossier temporaire
    rm -rf /mnt/tmp/dotfiles
    
    echo "✅ Configuration importée !"
else
    # Si vous avez copié le dossier "dotfiles" manuellement dans le dossier home de l'utilisateur
    if [ -d "$HOME/dotfiles/nixos" ]; then
        echo "Dossier local détecté. Copie en cours..."
        sudo cp -r "$HOME/dotfiles/nixos/"* /mnt/etc/nixos/
        echo "✅ Fichiers locaux copiés."
    else
        echo "⚠️  Aucun dotfile trouvé. Vous devrez éditer configuration.nix manuellement."
    fi
fi

# Petite sécurité : On s'assure que hardware-configuration.nix est bien présent
# (Au cas où vos dotfiles l'auraient écrasé avec une version incompatible)
if [ ! -f /mnt/etc/nixos/hardware-configuration.nix ]; then
    echo "⚠️  Attention : hardware-configuration.nix manquant ! Régénération..."
    nixos-generate-config --root /mnt
fi

echo ""
echo "============================================"
echo "✅ TERMINÉ !"
echo "Vérifiez vos fichiers avant d'installer :"
echo "ls -la /mnt/etc/nixos/"
echo "Puis lancez : nixos-install"
echo "============================================"