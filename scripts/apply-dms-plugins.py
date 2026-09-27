#!/usr/bin/env python3
"""Merge versioned defaults into local DMS plugin settings, through IPC if running."""

import json
import subprocess
from pathlib import Path

root = Path(__file__).resolve().parent.parent
config = root / "dms/.config/DankMaterialShell"
defaults = json.loads((config / "plugin-defaults.json").read_text())


def ipc(*args):
    result = subprocess.run(
        ["dms", "ipc", "call", *args],
        text=True,
        capture_output=True,
        timeout=10,
        check=False,
    )
    if result.returncode:
        raise RuntimeError(result.stderr or result.stdout)
    return result.stdout.strip()


try:
    settings = json.loads(ipc("settings", "get", "pluginSettings"))
    bars = json.loads(ipc("settings", "get", "barConfigs"))
    online = True
except (RuntimeError, ValueError, subprocess.TimeoutExpired):
    runtime = config / "plugin_settings.json"
    settings = json.loads(runtime.read_text()) if runtime.exists() else {}
    full = json.loads((config / "settings.json").read_text())
    bars = full.get("barConfigs", [])
    online = False
for plugin, values in defaults.items():
    settings.setdefault(plugin, {}).update(values)
for bar in bars:
    if not bar.get("enabled", True):
        continue
    widgets = bar.setdefault("rightWidgets", [])
    present = {
        x if isinstance(x, str) else x.get("id", x.get("widgetId")) for x in widgets
    }
    for widget in ("dankKDEConnect", "intelGpuMonitor"):
        if widget not in present:
            widgets.insert(max(0, len(widgets) - 1), widget)
    break
# These composite settings are not writable through the generic settings IPC.
# Persist them, then reload the shell so its caches use the same values.
(config / "plugin_settings.json").write_text(json.dumps(settings, indent=2) + "\n")
full = json.loads((config / "settings.json").read_text())
full["barConfigs"] = bars
(config / "settings.json").write_text(json.dumps(full, indent=2) + "\n")
if online:
    subprocess.run(["dms", "restart"], check=True, timeout=30)
else:
    print("Préférences enregistrées ; les plugins seront chargés au démarrage de DMS.")
