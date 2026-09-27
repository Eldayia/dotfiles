#!/usr/bin/env python3
"""Actions Nautilus locales : arguments séparés, originaux conservés."""

import datetime
import hashlib
import hmac
import os
import re
import stat
import subprocess
import sys
import tarfile
import tempfile
from pathlib import Path
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


def notify(message):
    subprocess.run(["notify-send", "Scripts Nautilus", message], check=False)


def terminal(command, cwd=None):
    args = ["ghostty", "--gtk-single-instance=false"]
    if cwd:
        args.append("--working-directory=" + cwd)
    subprocess.Popen([*args, "-e", *command], start_new_session=True)


def sha256(path):
    with open(path, "rb") as stream:
        return hashlib.file_digest(stream, "sha256").hexdigest()


def dated_name(label, suffix):
    stamp = (
        datetime.datetime.now(datetime.timezone.utc)
        .astimezone()
        .strftime("%Y-%m-%d_%H-%M-%S-%f")
    )
    return f"{label[:100]}-{stamp}{suffix}"


def archive(paths):
    selected = [Path(p) for p in paths]
    parent = selected[0].parent
    if any(p.parent != parent for p in selected):
        raise ValueError("Les éléments doivent se trouver dans le même dossier.")
    if any(p == p.parent for p in selected):
        raise ValueError("Choisis un fichier ou dossier autre que la racine.")
    name = selected[0].name if len(selected) == 1 else "selection"
    output = parent / dated_name(name, ".tar.gz")
    # Exclusive creation: an existing archive is never overwritten.
    with output.open("xb") as stream:
        try:
            with tarfile.open(fileobj=stream, mode="w:gz", dereference=False) as bundle:
                for p in selected:
                    bundle.add(p, arcname=p.name, recursive=True)
        except BaseException:
            output.unlink(missing_ok=True)
            raise
    return output


def convert_webp(paths):
    results = []
    for value in paths:
        source = Path(value)
        mime = subprocess.check_output(
            ["file", "--brief", "--mime-type", "--", str(source)], text=True
        ).strip()
        if not source.is_file() or not mime.startswith("image/"):
            raise ValueError(f"Ce fichier n’est pas une image : {source.name}")
    for value in paths:
        source = Path(value)
        output = source.parent / dated_name(source.stem, ".webp")
        fd, temp = tempfile.mkstemp(
            prefix=".nautilus-webp-", suffix=".webp", dir=source.parent
        )
        os.close(fd)
        try:
            # Only the first frame/page of an animated or multipage image.
            subprocess.run(
                ["magick", str(source) + "[0]", "-quality", "85", temp], check=True
            )
            os.link(temp, output)  # Fails instead of overwriting an existing file.
            results.append(output)
        finally:
            Path(temp).unlink(missing_ok=True)
    return results


def file_information(paths):
    for value in paths:
        p = Path(value)
        data = p.lstat()
        print(f"\n{'─' * 60}\nChemin : {str(p)!r}", flush=True)
        print(
            f"Taille : {data.st_size:,} octets | Droits : {stat.filemode(data.st_mode)}"
        )
        print(
            f"Modifié : {datetime.datetime.fromtimestamp(data.st_mtime, datetime.timezone.utc).astimezone().isoformat(' ', timespec='seconds')}",
            flush=True,
        )
        subprocess.run(["file", "--", str(p)], check=False)
        if p.is_file():
            subprocess.run(["mediainfo", str(p)], check=False)
        elif p.is_dir():
            subprocess.run(["du", "-sh", "--", str(p)], check=False)


def worker(action, paths):
    try:
        if action == "info":
            file_information(paths)
        elif action == "archive":
            output = archive(paths)
            print(f"Archive créée : {output}")
            notify(f"Archive créée : {output.name}")
        elif action == "webp":
            for p in convert_webp(paths):
                print(f"Image créée : {p}")
            notify("Conversion WebP terminée ; originaux conservés.")
        elif action == "sha256":
            for p in paths:
                print(f"{sha256(p)}  {p!r}")
        elif action == "verify":
            expected = subprocess.run(
                [
                    "zenity",
                    "--entry",
                    "--title=Vérifier SHA-256",
                    "--text=Colle l’empreinte SHA-256 attendue (64 caractères).",
                ],
                capture_output=True,
                text=True,
                check=False,
            )
            if expected.returncode:
                return
            digest = expected.stdout.strip().lower()
            if not re.fullmatch(r"[0-9a-f]{64}", digest):
                raise ValueError(
                    "L’empreinte doit contenir exactement 64 caractères hexadécimaux."
                )
            actual = sha256(paths[0])
            matches = hmac.compare_digest(digest, actual)
            print(f"Attendue : {digest}\nCalculée : {actual}")
            message = (
                "SHA-256 : les empreintes correspondent."
                if matches
                else "SHA-256 : les empreintes sont différentes !"
            )
            print(message)
            subprocess.run(
                ["zenity", "--info" if matches else "--error", "--text=" + message],
                check=False,
            )
    except (
        OSError,
        ValueError,
        subprocess.CalledProcessError,
        tarfile.TarError,
    ) as error:
        print(f"Erreur : {error}", file=sys.stderr)
        notify(str(error))
    finally:
        try:
            input("\nAppuie sur Entrée pour fermer.")
        except EOFError:
            pass


def main(action, args):
    paths = selected_paths(args)
    if action in ("lazygit", "nvim") and not paths:
        uri = os.environ.get("NAUTILUS_SCRIPT_CURRENT_URI", "")
        paths = [local_path(uri)] if uri else [os.getcwd()]
    if not paths:
        raise ValueError("Sélectionne au moins un fichier ou dossier.")
    if any(not os.path.lexists(p) for p in paths):
        raise ValueError("Un élément sélectionné n’existe plus.")
    if action == "meld":
        if len(paths) != 2 or not (
            all(Path(p).is_file() for p in paths)
            or all(Path(p).is_dir() for p in paths)
        ):
            raise ValueError("Sélectionne exactement deux fichiers ou deux dossiers.")
        subprocess.Popen(["meld", "--", *paths], start_new_session=True)
    elif action == "copy":
        subprocess.run(
            ["wl-copy", "--type", "text/plain;charset=utf-8"],
            input="\n".join(paths),
            text=True,
            check=True,
        )
    elif action == "lazygit":
        if len(paths) != 1 or not Path(paths[0]).is_dir():
            raise ValueError("Sélectionne un seul dossier de dépôt Git.")
        result = subprocess.run(
            ["git", "-C", paths[0], "rev-parse", "--is-inside-work-tree"],
            text=True,
            capture_output=True,
            check=False,
        )
        if result.returncode or result.stdout.strip() != "true":
            raise ValueError("Ce dossier ne fait pas partie d’un dépôt Git.")
        terminal(["lazygit"], cwd=paths[0])
    elif action == "nvim":
        cwd = paths[0] if Path(paths[0]).is_dir() else str(Path(paths[0]).parent)
        terminal(["nvim", "--", *paths], cwd=cwd)
    elif action in ("info", "archive", "webp", "verify", "sha256"):
        if action in ("verify", "sha256", "webp") and any(
            not Path(p).is_file() for p in paths
        ):
            raise ValueError("Cette action nécessite des fichiers, sans dossier.")
        if action == "verify" and len(paths) != 1:
            raise ValueError("Sélectionne un seul fichier à vérifier.")
        terminal(
            [sys.executable, str(Path(__file__).resolve()), "--worker", action, *paths]
        )
    else:
        raise ValueError("Action inconnue.")


if __name__ == "__main__":
    try:
        if len(sys.argv) > 2 and sys.argv[1] == "--worker":
            worker(sys.argv[2], sys.argv[3:])
        else:
            main(sys.argv[1], sys.argv[2:])
    except (ValueError, OSError, subprocess.CalledProcessError) as error:
        notify(str(error))
        sys.exit(1)
