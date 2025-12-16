#!/usr/bin/env bash
# Script de déploiement pour la VM NixOS
# Usage: cd ~/dotfiles && ./scripts/deploy-vm.sh

set -e

echo "=== Déploiement des dotfiles sur NixOS VM ==="

# Vérifier qu'on est sur NixOS
if [ ! -f /etc/NIXOS ]; then
    echo "❌ Erreur: Ce script doit être exécuté depuis NixOS"
    exit 1
fi

# Déterminer la racine du dépôt
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

# Se déplacer à la racine du dépôt
cd "$REPO_ROOT"

# Vérifier qu'on est dans le bon répertoire
if [ ! -f "CLAUDE.md" ]; then
    echo "❌ Erreur: CLAUDE.md non trouvé dans $REPO_ROOT"
    exit 1
fi

echo "✓ Système: NixOS"
echo "✓ Répertoire: $(pwd)"
echo ""

# Sauvegarder les fichiers existants qui pourraient causer des conflits
echo "💾 Sauvegarde des fichiers existants..."
BACKUP_DIR=~/dotfiles-backup-$(date +%Y%m%d-%H%M%S)
mkdir -p "$BACKUP_DIR"

# Liste des fichiers/dossiers qui peuvent causer des conflits
CONFLICT_PATHS=(
    ".config/nushell/config.nu"
    ".config/nushell/env.nu"
)

for path in "${CONFLICT_PATHS[@]}"; do
    if [ -e ~/"$path" ] && [ ! -L ~/"$path" ]; then
        echo "  Sauvegarde: $path"
        mkdir -p "$BACKUP_DIR/$(dirname "$path")"
        mv ~/"$path" "$BACKUP_DIR/$path"
    fi
done

if [ -d "$BACKUP_DIR/.config" ]; then
    echo "✓ Fichiers sauvegardés dans: $BACKUP_DIR"
else
    rmdir "$BACKUP_DIR" 2>/dev/null || true
    echo "✓ Aucun fichier à sauvegarder"
fi
echo ""

# Déployer les dotfiles avec Stow
echo "📦 Déploiement des dotfiles avec Stow..."
stow -v -t ~/ .
echo "✓ Dotfiles déployés"
echo ""

# Vérifier que Hyprland est bien configuré
if [ -f ~/.config/hypr/hyprland.conf ]; then
    echo "✓ Configuration Hyprland trouvée"
else
    echo "❌ Configuration Hyprland manquante"
    exit 1
fi

# Mettre à jour la configuration NixOS
echo "🔧 Mise à jour de la configuration NixOS..."
sudo cp -r nixos/* /etc/nixos/
echo "✓ Configuration NixOS copiée"
echo ""

# Rebuilder le système
echo "🔨 Reconstruction du système NixOS..."
sudo nixos-rebuild switch
echo "✓ Système reconstruit"
echo ""

echo "=== Déploiement terminé! ==="
echo ""
echo "Prochaines étapes:"
echo "1. Déconnectez-vous de votre session (Ctrl+M pour quitter Hyprland)"
echo "2. Reconnectez-vous"
echo "3. Hyprland devrait fonctionner correctement"
echo ""
echo "Raccourcis principaux:"
echo "  Ctrl+Space     : Wofi (lanceur)"
echo "  Ctrl+T         : Terminal (Warp)"
echo "  Ctrl+B         : Navigateur (Edge)"
echo "  Ctrl+E         : File manager (Yazi)"
echo "  Ctrl+C         : Fermer fenêtre"
echo "  Ctrl+M         : Quitter Hyprland"
