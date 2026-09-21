#!/usr/bin/env bash
set -euo pipefail
gsettings set org.gtk.gtk4.Settings.FileChooser sort-directories-first true
gsettings set org.gnome.nautilus.preferences show-create-link true
# Keep RabbitVCS runtime history outside dotfiles; apply only preferences.
if pacman -Q rabbitvcs >/dev/null 2>&1; then
    python - <<'PYCONFIG'
from rabbitvcs.util.settings import SettingsManager
settings = SettingsManager()
settings.set("external", "diff_tool", "/usr/bin/meld")
settings.write()
PYCONFIG
fi
