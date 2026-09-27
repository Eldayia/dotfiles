import importlib.util
import subprocess
import tarfile
from pathlib import Path
from unittest.mock import patch

import pytest

MODULE = Path(__file__).resolve().parents[1] / "nautilus/.config/nautilus/actions.py"
spec = importlib.util.spec_from_file_location("nautilus_actions", MODULE)
actions = importlib.util.module_from_spec(spec)
spec.loader.exec_module(actions)


@pytest.fixture(autouse=True)
def no_selection(monkeypatch):
    monkeypatch.delenv("NAUTILUS_SCRIPT_SELECTED_URIS", raising=False)


def test_uri_round_trip_and_remote_rejection(tmp_path):
    path = tmp_path / "espace ;$(echo danger)\nnom.txt"
    assert actions.local_path(path.as_uri()) == str(path)
    with pytest.raises(ValueError):
        actions.local_path("sftp://serveur/fichier")


def test_nvim_arguments_are_not_shell_code(tmp_path):
    path = tmp_path / "a ;$(touch BAD).txt"
    path.write_text("a")
    with patch.object(actions, "terminal") as launch:
        actions.main("nvim", [str(path)])
    assert launch.call_args.args[0] == ["nvim", "--", str(path)]


def test_clipboard_uri_preserves_filename(tmp_path, monkeypatch):
    path = tmp_path / "nom avec\nretour.txt"
    path.write_text("a")
    monkeypatch.setenv("NAUTILUS_SCRIPT_SELECTED_URIS", path.as_uri())
    with patch.object(actions.subprocess, "run") as run:
        actions.main("copy", [])
    assert run.call_args.kwargs["input"] == str(path)


def test_archive_preserves_files_and_symlinks(tmp_path):
    folder = tmp_path / "dossier"
    folder.mkdir()
    (folder / "original.txt").write_text("original")
    (folder / "lien").symlink_to("/etc/passwd")
    archive = actions.archive([str(folder)])
    with tarfile.open(archive) as bundle:
        assert bundle.extractfile("dossier/original.txt").read() == b"original"
        assert bundle.getmember("dossier/lien").issym()
        assert len(bundle.getmembers()) == 3
    assert (folder / "original.txt").read_text() == "original"


def test_archive_never_overwrites(tmp_path, monkeypatch):
    source = tmp_path / "source.txt"
    source.write_text("source")
    destination = tmp_path / "existing.tar.gz"
    destination.write_text("keep")
    monkeypatch.setattr(actions, "dated_name", lambda *_: destination.name)
    with pytest.raises(FileExistsError):
        actions.archive([str(source)])
    assert destination.read_text() == "keep"


def test_webp_preserves_original(tmp_path):
    source = tmp_path / "image ; nom.png"
    subprocess.run(["magick", "-size", "2x2", "xc:red", str(source)], check=True)
    original = source.read_bytes()
    outputs = actions.convert_webp([str(source)])
    assert len(outputs) == 1
    assert outputs[0].read_bytes().startswith(b"RIFF")
    assert source.read_bytes() == original
    assert not list(tmp_path.glob(".nautilus-webp-*"))


def test_checksum(tmp_path):
    source = tmp_path / "hash.txt"
    source.write_bytes(b"abc")
    assert (
        actions.sha256(source)
        == "ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad"
    )


def test_invalid_selections(tmp_path):
    with pytest.raises(ValueError):
        actions.main("verify", [str(tmp_path)])
    with pytest.raises(ValueError):
        actions.main("meld", [str(tmp_path)])
    with pytest.raises(ValueError):
        actions.main("lazygit", [str(tmp_path)])
