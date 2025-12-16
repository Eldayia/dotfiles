#!/usr/bin/env bash
# Script de synchronisation de /etc/nixos vers le dépôt
# Usage: cd ~/dotfiles && ./scripts/sync-nixos.sh

set -e

# Déterminer la racine du dépôt
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
cd "$REPO_ROOT"

echo "Copie de /etc/nixos dans $REPO_ROOT/nixos (avec sudo)..."
sudo cp -r /etc/nixos/. "$REPO_ROOT/nixos"

echo "Changement de propriétaire et permissions dans $REPO_ROOT/nixos..."
sudo chown -R $(whoami):$(id -gn) "$REPO_ROOT/nixos"
chmod -R u+rw "$REPO_ROOT/nixos"

echo "Affichage des différences avec diff-so-fancy :"
git diff --color | diff-so-fancy

read -rp "Ajouter tous les fichiers modifiés à git ? (y/n) : " add_all
if [[ "$add_all" =~ ^[Yy]$ ]]; then
  git add .
else
  echo "Veuillez ajouter manuellement les fichiers avant de commiter."
  exit 1
fi

read -rp "Message de commit : " msg
if [[ -z "$msg" ]]; then
  echo "Message de commit vide, abandon."
  exit 1
fi

git commit -m "$msg"

branch=$(git rev-parse --abbrev-ref HEAD)
git push origin "$branch"

echo "Terminé avec succès."
