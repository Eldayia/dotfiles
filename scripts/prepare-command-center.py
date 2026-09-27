#!/usr/bin/env python3
"""Build the local DMS UI from verified, pinned upstream sources."""
import gzip
import hashlib
import io
import os
import shutil
import subprocess
import tarfile
import tempfile
import urllib.request
from pathlib import Path

root = Path(__file__).resolve().parent.parent
home = Path.home()
version = subprocess.check_output(["/usr/bin/dms", "version"], text=True).strip()
if version != "dms v1.6.2":
    raise SystemExit("This UI patch targets dms v1.6.2. Rebase it before using a newer DMS.")
assets = {
    "dms": ("https://github.com/AvengeMedia/DankMaterialShell/archive/refs/tags/v1.6.2.tar.gz", "5eff09d35d39b18f9d593f0f464e2fb5be3ddf6c92fa9eb1e99c534126c62419"),
    "common": ("https://github.com/AvengeMedia/dank-qml-common/archive/26396ce432d6c71c3f5367438f96f4a8d667e160.tar.gz", "f5aa4d56a937a275c9ee504c567c36c141cb11297cae934f1b5cf3cf3620de10"),
    "dsearch": ("https://github.com/AvengeMedia/danksearch/releases/download/v1.6.0/dsearch-linux-amd64.gz", "e7ebc1d3032ef89006ab8a43746bf503f387decd018ff3977bb1550cb2c5b36a"),
}
if subprocess.check_output(["uname", "-m"], text=True).strip() != "x86_64":
    raise SystemExit("This pinned dsearch binary is for x86_64.")
cache = home / ".cache/command-center-sources"
cache.mkdir(parents=True, exist_ok=True)
def download(name):
    url, expected = assets[name]
    path = cache / expected
    data = path.read_bytes() if path.exists() else urllib.request.urlopen(url, timeout=90).read()
    if hashlib.sha256(data).hexdigest() != expected:
        raise SystemExit("Checksum mismatch: " + name)
    path.write_bytes(data)
    return data
with tempfile.TemporaryDirectory(prefix="dms-command-center-") as tmp:
    tmp = Path(tmp)
    for name in ["dms", "common"]:
        dest = tmp / name
        dest.mkdir()
        with tarfile.open(fileobj=io.BytesIO(download(name)), mode="r:gz") as archive:
            archive.extractall(dest, filter="data")
    src = next((tmp / "dms").iterdir()) / "quickshell"
    common = next((tmp / "common").iterdir()) / "DankCommon"
    link = src / "DankCommon"
    if link.is_symlink(): link.unlink()
    shutil.copytree(common, link, dirs_exist_ok=True)
    subprocess.run(["patch", "--batch", "--fuzz=0", "-p1", "-i", str(root / "dms/patches/command-center-v1.6.2.patch")], cwd=src, check=True)
    base = home / ".local/share/dms-command-center"
    base.mkdir(parents=True, exist_ok=True)
    target = base / "quickshell"
    staged = base / "quickshell.next"
    if staged.exists(): shutil.rmtree(staged)
    shutil.copytree(src, staged, symlinks=True)
    previous = base / "quickshell.previous"
    if previous.exists():
        for directory, _, _ in os.walk(previous):
            Path(directory).chmod(Path(directory).stat().st_mode | 0o700)
        shutil.rmtree(previous)
    if target.exists(): target.rename(previous)
    staged.rename(target)
    binary = home / ".local/bin/dsearch"
    binary.parent.mkdir(parents=True, exist_ok=True)
    staged_binary = binary.with_suffix(".new")
    staged_binary.write_bytes(gzip.decompress(download("dsearch")))
    staged_binary.chmod(0o755)
    staged_binary.replace(binary)
print("DMS UI and dsearch prepared; checksums and patch verified.")
