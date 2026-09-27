#!/usr/bin/env bash
set -Eeuo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
packages=()
for directory in "$ROOT"/*/; do
    [[ -d "$directory/.config" || -d "$directory/.local" || -f "$directory/.bashrc" || -f "$directory/.zshrc" ]] || continue
    packages+=("$(basename "$directory")")
done
if ((${#packages[@]})); then
    stow --dir="$ROOT" --target="$HOME" --simulate --restow "${packages[@]}"
    stow --dir="$ROOT" --target="$HOME" --restow "${packages[@]}"
fi
