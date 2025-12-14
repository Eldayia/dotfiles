{ config, pkgs, ... }:

{
  # --- RÉSEAU ---
  networking.hostName = "nixos-hypr"; # Nom de la machine
  networking.networkmanager.enable = true; # Gestionnaire réseau simple
}
