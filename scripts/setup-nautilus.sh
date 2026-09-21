#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
stow --dir="$ROOT" --target="$HOME" --no-folding --simulate --restow nautilus
stow --dir="$ROOT" --target="$HOME" --no-folding --restow nautilus
bash "$ROOT/nautilus/.config/nautilus/apply-settings.sh"
