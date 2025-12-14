#!/usr/bin/env bash
# Script de démarrage pour Hyprland
# Assure que les applications NixOS sont accessibles

# Charger le profile systemwide
if [ -f /etc/profile ]; then
  source /etc/profile
fi

# Ajouter les chemins Nix au PATH
export PATH="$HOME/.nix-profile/bin:$HOME/.config/nix/profile/bin:/nix/var/nix/profiles/default/bin:/run/current-system/sw/bin:/etc/profiles/per-user/$USER/bin:$PATH"

# Lancer Hyprland
exec Hyprland "$@"
