#!/usr/bin/env bash
# Script de synchronisation des dotfiles vers Git
# Usage: cd ~/dotfiles && ./scripts/sync-dotfiles.sh

set -e

BRANCH="nixos"

# Déterminer la racine du dépôt
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
cd "$REPO_ROOT"

echo "🔍 Checking for changes in dotfiles..."

git add .

if git diff --cached --quiet; then
  echo "✅ Rien à commit, dotfiles à jour."
  exit 0
fi

echo "🎨 Changes staged:"
git diff --cached | diff-so-fancy

echo
read -rp "💬 Tape le message de commit (ou ENTER pour annuler) : " COMMIT_MSG

if [[ -z "$COMMIT_MSG" ]]; then
  echo "❌ Commit annulé."
  exit 1
fi

git commit -m "$COMMIT_MSG"
git push origin "$BRANCH"
echo "🚀 Dotfiles poussés sur la branche $BRANCH."
