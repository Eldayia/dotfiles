#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
stow --dir="$ROOT" --target="$HOME" --simulate --restow dms
stow --dir="$ROOT" --target="$HOME" --restow dms
# Plugin sources are managed by DMS; the portable lockfile is versioned.
dms plugins restore "$ROOT/dms/.config/DankMaterialShell/plugins.lock.json"
python "$ROOT/scripts/apply-dms-plugins.py"
