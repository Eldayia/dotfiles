#!/usr/bin/env bash
# Script de déploiement pour la VM NixOS

set -e

echo "=== Déploiement des dotfiles sur NixOS VM ==="

# Vérifier qu'on est sur NixOS
if [ ! -f /etc/NIXOS ]; then
    echo "❌ Erreur: Ce script doit être exécuté depuis NixOS"
    exit 1
fi

# Vérifier qu'on est dans le bon répertoire
if [ ! -f "CLAUDE.md" ]; then
    echo "❌ Erreur: Exécutez ce script depuis la racine du dépôt dotfiles"
    exit 1
fi

echo "✓ Système: NixOS"
echo "✓ Répertoire: $(pwd)"
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
