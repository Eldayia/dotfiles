#!/usr/bin/env bash

set -Eeuo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

SOURCE="$HOME/.config/DankMaterialShell"
DEST="$ROOT/dms/.config/DankMaterialShell"

if [[ -L "$SOURCE" ]]; then
    echo "DMS est déjà géré par Stow."
    exit 0
fi

if [[ ! -d "$SOURCE" ]]; then
    echo "DMS n'a pas encore créé sa configuration."
    echo "Lance et configure DMS avant ce script."
    exit 1
fi

mkdir -p "$ROOT/dms/.config"

mv "$SOURCE" "$DEST"

cd "$ROOT"

stow --target="$HOME" dms

echo
echo "DMS est maintenant géré par les dotfiles."
