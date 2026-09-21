#!/usr/bin/env python3
"""Local-file actions shared by the Nautilus scripts."""
import os
from pathlib import Path
import subprocess
import sys
from urllib.parse import unquote, urlsplit


def local_path(uri):
    value = urlsplit(uri)
    if value.scheme != "file" or value.netloc not in ("", "localhost"):
        raise ValueError("Cette action nécessite des fichiers locaux.")
    return os.path.abspath(unquote(value.path))


def selected_paths(args):
    uris = os.environ.get("NAUTILUS_SCRIPT_SELECTED_URIS", "").splitlines()
    if uris:
        return [local_path(uri) for uri in uris]
    return [os.path.abspath(arg) for arg in args]


def main(action, args):
    paths = selected_paths(args)
    if action == "meld":
        if len(paths) != 2:
            raise ValueError("Sélectionne exactement deux fichiers ou deux dossiers.")
        if not (all(Path(p).is_file() for p in paths) or
                all(Path(p).is_dir() for p in paths)):
            raise ValueError("Choisis deux fichiers existants ou deux dossiers existants.")
        subprocess.Popen(["meld", "--", *paths], start_new_session=True)
    elif action == "copy":
        if not paths:
            raise ValueError("Sélectionne au moins un fichier ou dossier.")
        subprocess.run(["wl-copy", "--type", "text/plain;charset=utf-8"],
                       input="\n".join(paths), text=True, check=True)
    elif action == "lazygit":
        if not paths:
            uri = os.environ.get("NAUTILUS_SCRIPT_CURRENT_URI", "")
            paths = [local_path(uri)] if uri else [os.getcwd()]
        if len(paths) != 1 or not Path(paths[0]).is_dir():
            raise ValueError("Sélectionne un seul dossier de dépôt Git.")
        result = subprocess.run(["git", "-C", paths[0], "rev-parse", "--is-inside-work-tree"],
                                text=True, capture_output=True, check=False)
        if result.returncode or result.stdout.strip() != "true":
            raise ValueError("Ce dossier ne fait pas partie d’un dépôt Git.")
        subprocess.Popen(["ghostty", "--gtk-single-instance=false",
                          "--working-directory=" + paths[0], "-e", "lazygit"],
                         start_new_session=True)
    else:
        raise ValueError("Action inconnue.")


if __name__ == "__main__":
    try:
        main(sys.argv[1], sys.argv[2:])
    except (ValueError, OSError, subprocess.CalledProcessError) as error:
        subprocess.run(["notify-send", "Scripts Nautilus", str(error)], check=False)
        sys.exit(1)
