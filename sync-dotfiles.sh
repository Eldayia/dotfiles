#!/usr/bin/env bash
set -e

BRANCH="nixos"

cd "$(dirname "$0")"

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
