#!/usr/bin/env bash

set -Eeuo pipefail

echo
echo "As-tu testé Niri avec :"
echo
echo "    niri-session -l"
echo

read -r -p "Niri fonctionne correctement ? [y/N] " answer

case "$answer" in
    y|Y|yes|YES)
        ;;
    *)
        echo "Abandon."
        exit 1
        ;;
esac

if ! command -v dms-greeter >/dev/null; then
    echo "dms-greeter n'est pas installé."
    exit 1
fi

dms-greeter enable
dms-greeter sync

sudo systemctl enable greetd.service

echo
echo "Greeter installé."
echo "Redémarre quand tu es prête."
