#!/usr/bin/env bash
set -Eeuo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

install_from_list() {
    local list_file="$1"
    shift

    [[ -f "$list_file" ]] || return 0

    while IFS= read -r item; do
        [[ -n "$item" && "$item" != \#* ]] || continue
        "$@" "$item"
    done < "$list_file"
}

echo "======================================"
echo " IDE : extensions et plugins"
echo "======================================"

if command -v code >/dev/null 2>&1; then
    install_from_list \
        "$ROOT/packages/vscode-extensions.txt" \
        code --install-extension
else
    echo "VS Code absent, extensions ignorées."
fi

if command -v clion >/dev/null 2>&1; then
    install_from_list \
        "$ROOT/packages/clion-plugins.txt" \
        clion installPlugins
else
    echo "CLion absent, plugins ignorés."
fi

echo
echo "Réglages suivis :"
echo "  - VS Code : préférences utilisateur et liste d’extensions"
echo "  - CLion   : thème et style de code C++"
echo
echo "Les comptes, licences, projets récents, caches et index restent locaux."
