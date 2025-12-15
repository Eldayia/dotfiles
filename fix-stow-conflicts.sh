#!/usr/bin/env bash
# Script pour résoudre les conflits Stow

set -e

echo "=== Résolution des conflits Stow ==="
echo ""

# Créer un répertoire de backup
BACKUP_DIR=~/dotfiles-backup-$(date +%Y%m%d-%H%M%S)
mkdir -p "$BACKUP_DIR"

echo "📂 Répertoire de backup: $BACKUP_DIR"
echo ""

# Détecter et sauvegarder les fichiers en conflit
echo "🔍 Détection des fichiers en conflit..."
CONFLICTS_FOUND=0

# Vérifier .config/nushell/
if [ -e ~/.config/nushell/config.nu ] && [ ! -L ~/.config/nushell/config.nu ]; then
    echo "  ⚠️  Conflit détecté: .config/nushell/config.nu"
    mkdir -p "$BACKUP_DIR/.config/nushell"
    mv ~/.config/nushell/config.nu "$BACKUP_DIR/.config/nushell/"
    CONFLICTS_FOUND=$((CONFLICTS_FOUND + 1))
fi

if [ -e ~/.config/nushell/env.nu ] && [ ! -L ~/.config/nushell/env.nu ]; then
    echo "  ⚠️  Conflit détecté: .config/nushell/env.nu"
    mkdir -p "$BACKUP_DIR/.config/nushell"
    mv ~/.config/nushell/env.nu "$BACKUP_DIR/.config/nushell/"
    CONFLICTS_FOUND=$((CONFLICTS_FOUND + 1))
fi

# Vérifier d'autres potentiels conflits dans .config/
for dir in ~/.config/*/; do
    dirname=$(basename "$dir")
    if [ -d "$(pwd)/.config/$dirname" ]; then
        # Vérifier si des fichiers non-symlinks existent
        while IFS= read -r -d '' file; do
            rel_path=".config/$dirname/$(basename "$file")"
            if [ ! -L "$file" ] && [ -f "$(pwd)/$rel_path" ]; then
                echo "  ⚠️  Conflit détecté: $rel_path"
                mkdir -p "$BACKUP_DIR/.config/$dirname"
                mv "$file" "$BACKUP_DIR/$rel_path"
                CONFLICTS_FOUND=$((CONFLICTS_FOUND + 1))
            fi
        done < <(find "$dir" -maxdepth 1 -type f -print0 2>/dev/null)
    fi
done

echo ""
if [ $CONFLICTS_FOUND -gt 0 ]; then
    echo "✓ $CONFLICTS_FOUND fichier(s) sauvegardé(s) dans: $BACKUP_DIR"
    echo ""
    echo "Vous pouvez maintenant exécuter:"
    echo "  cd ~/dotfiles"
    echo "  stow -v -t ~/ ."
else
    rmdir "$BACKUP_DIR" 2>/dev/null || true
    echo "✓ Aucun conflit détecté"
    echo ""
    echo "Le problème peut être ailleurs. Essayez:"
    echo "  stow -v -t ~/ . 2>&1 | less"
    echo ""
    echo "Ou utilisez --adopt pour adopter les fichiers existants:"
    echo "  stow --adopt -v -t ~/ ."
fi

echo ""
echo "=== Terminé ==="
