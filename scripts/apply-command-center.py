#!/usr/bin/env python3
"""Apply versioned DMS launcher defaults without replacing other session state."""
import json
import os
from pathlib import Path

root = Path(__file__).resolve().parent.parent
config = Path(os.environ.get("XDG_CONFIG_HOME", Path.home() / ".config")) / "DankMaterialShell"
state = Path(os.environ.get("XDG_STATE_HOME", Path.home() / ".local/state")) / "DankMaterialShell"
defaults = json.loads((root / "dms/.config/DankMaterialShell/command-center-defaults.json").read_text())
def merge(path, changes):
    path.parent.mkdir(parents=True, exist_ok=True)
    data = json.loads(path.read_text()) if path.exists() else {}
    for key, value in changes.items():
        if isinstance(value, dict):
            data[key] = {**data.get(key, {}), **value}
        else:
            data[key] = value
    temporary = path.with_suffix(".command-center.tmp")
    temporary.write_text(json.dumps(data, ensure_ascii=False, indent=2) + "\n")
    temporary.replace(path)
merge(config / "settings.json", defaults["settings"])
session_path = state / "session.json"
session = json.loads(session_path.read_text()) if session_path.exists() else {}
pins = list(dict.fromkeys(defaults["pinnedApps"] + session.get("pinnedApps", [])))
merge(session_path, {"pinnedApps": pins, "launcherLastMode": "all"})
print("DMS : favoris en grille et recherche globale configurés.")
