#!/usr/bin/env bash

# Script pour mettre à jour la configuration NixOS depuis le dépôt dotfiles
# Usage: cd ~/dotfiles && sudo ./scripts/install-update.sh

set -e  # Arrêter en cas d'erreur

echo "============================================"
echo "   MISE À JOUR CONFIGURATION NIXOS         "
echo "============================================"
echo ""

# --- VÉRIFICATION DES DROITS ROOT ---
if [ "$EUID" -ne 0 ]; then
    echo "❌ Erreur: Ce script doit être exécuté avec sudo"
    echo "Usage: sudo ./install-update.sh"
    exit 1
fi

# --- VÉRIFICATION DU RÉPERTOIRE ---
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
NIXOS_SOURCE="$REPO_ROOT/nixos"

if [ ! -d "$NIXOS_SOURCE" ]; then
    echo "❌ Erreur: Le dossier nixos/ n'existe pas dans $REPO_ROOT"
    echo "   Ce script doit être dans dotfiles/scripts/"
    exit 1
fi

echo "📁 Source: $NIXOS_SOURCE"
echo "📁 Destination: /etc/nixos"
echo ""

# --- SAUVEGARDE ---
BACKUP_DIR="/etc/nixos-backup-$(date +%Y%m%d-%H%M%S)"
echo "💾 Création d'une sauvegarde dans: $BACKUP_DIR"

mkdir -p "$BACKUP_DIR"

# Sauvegarder les fichiers existants (sauf hardware-configuration.nix)
if [ -f /etc/nixos/configuration.nix ]; then
    cp /etc/nixos/configuration.nix "$BACKUP_DIR/"
    echo "   ✓ configuration.nix sauvegardé"
fi

if [ -d /etc/nixos/modules ]; then
    cp -r /etc/nixos/modules "$BACKUP_DIR/"
    echo "   ✓ modules/ sauvegardé"
fi

if [ -d /etc/nixos/services ]; then
    cp -r /etc/nixos/services "$BACKUP_DIR/"
    echo "   ✓ services/ sauvegardé"
fi

echo ""

# --- COPIE DES FICHIERS ---
echo "📋 Copie des fichiers de configuration..."

# Copier configuration.nix
if [ -f "$NIXOS_SOURCE/configuration.nix" ]; then
    cp "$NIXOS_SOURCE/configuration.nix" /etc/nixos/
    echo "   ✓ configuration.nix copié"
else
    echo "   ⚠️  configuration.nix non trouvé"
fi

# Copier le dossier modules/
if [ -d "$NIXOS_SOURCE/modules" ]; then
    cp -r "$NIXOS_SOURCE/modules" /etc/nixos/
    echo "   ✓ modules/ copié"
else
    echo "   ⚠️  modules/ non trouvé"
fi

# Copier le dossier services/
if [ -d "$NIXOS_SOURCE/services" ]; then
    cp -r "$NIXOS_SOURCE/services" /etc/nixos/
    echo "   ✓ services/ copié"
else
    echo "   ⚠️  services/ non trouvé"
fi

echo ""

# --- VÉRIFICATION hardware-configuration.nix ---
if [ ! -f /etc/nixos/hardware-configuration.nix ]; then
    echo "⚠️  ATTENTION: hardware-configuration.nix n'existe pas!"
    echo "   Vous devez générer ce fichier avec:"
    echo "   sudo nixos-generate-config"
    echo ""
fi

# --- RÉSUMÉ ---
echo "============================================"
echo "✅ MISE À JOUR TERMINÉE !"
echo "============================================"
echo ""
echo "Fichiers copiés dans /etc/nixos:"
echo "  - configuration.nix"
echo "  - modules/"
echo "  - services/"
echo ""
echo "⚠️  hardware-configuration.nix n'a PAS été modifié (normal)"
echo ""
echo "📦 Sauvegarde créée dans: $BACKUP_DIR"
echo ""
echo "Prochaines étapes:"
echo "  1. Vérifier la configuration: sudo nvim /etc/nixos/configuration.nix"
echo "  2. Tester: sudo nixos-rebuild test"
echo "  3. Activer: sudo nixos-rebuild switch"
echo ""
