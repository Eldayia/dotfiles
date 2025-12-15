{ config, pkgs, ... }:

{
  # --- LOGIN MANAGER : LY ---
  services.displayManager.ly.enable = true;

  # --- SESSION PAR DÉFAUT : HYPRLAND ---
  services.displayManager.defaultSession = "hyprland";
}
