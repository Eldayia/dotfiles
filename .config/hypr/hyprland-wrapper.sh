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

# Configurer les variables de session Wayland
export XDG_SESSION_TYPE=wayland
export XDG_SESSION_DESKTOP=Hyprland
export XDG_CURRENT_DESKTOP=Hyprland

# Variables Wayland essentielles
export WAYLAND_DISPLAY=wayland-1
export QT_QPA_PLATFORM=wayland
export GDK_BACKEND=wayland
export CLUTTER_BACKEND=wayland
export SDL_VIDEODRIVER=wayland

# Variables pour VM
export WLR_NO_HARDWARE_CURSORS=1

# Lancer Hyprland avec debug
exec Hyprland "$@"
