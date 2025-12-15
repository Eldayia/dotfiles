#!/usr/bin/env bash

# Wrapper pour lancer Hyprland avec les variables d'environnement correctes

# Définir XDG_RUNTIME_DIR si non défini
if [ -z "$XDG_RUNTIME_DIR" ]; then
  export XDG_RUNTIME_DIR="/run/user/$(id -u)"
fi

# Créer le répertoire s'il n'existe pas
if [ ! -d "$XDG_RUNTIME_DIR" ]; then
  sudo mkdir -p "$XDG_RUNTIME_DIR"
  sudo chown "$(id -u):$(id -g)" "$XDG_RUNTIME_DIR"
  sudo chmod 700 "$XDG_RUNTIME_DIR"
fi

# Lancer Hyprland
exec Hyprland "$@"
