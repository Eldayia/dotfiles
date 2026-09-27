#!/usr/bin/env bash
set -Eeuo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
python "$ROOT/scripts/prepare-command-center.py"
stow --dir="$ROOT" --target="$HOME" --restow command-center dms environment
# systemd does not load a symlinked .service.d directory; link the file instead.
python - "$ROOT" <<'PYTHON'
from pathlib import Path
import sys, os
root = Path(sys.argv[1])
p = Path.home() / ".config/systemd/user/dms.service.d"
if p.is_symlink(): p.unlink()
p.mkdir(parents=True, exist_ok=True)
file = p / "command-center.conf"
target = root / "dms/.config/systemd/user/dms.service.d/command-center.conf"
if not file.exists(): file.symlink_to(os.path.relpath(target, file.parent))
elif file.resolve() != target.resolve():
    raise SystemExit("Existing command-center.conf differs; review before replacing it.")
PYTHON
python "$ROOT/scripts/apply-command-center.py"
export DMS_SHELL_DIR="$HOME/.local/share/dms-command-center/quickshell"
systemctl --user import-environment DMS_SHELL_DIR
systemctl --user daemon-reload
systemctl --user enable --now dsearch.service
systemctl --user restart dms.service
niri validate
niri msg action load-config-file
printf '\nCommand Center DMS prêt : Copilot ou Super+Maj+Espace.\n'
