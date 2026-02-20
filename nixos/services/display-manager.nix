{ config, pkgs, ... }:

{
  # --- LOGIN MANAGER : LY ---
  services.displayManager.ly.enable = true;

  # --- SESSION PAR DÉFAUT : NIRI ---
  services.displayManager.defaultSession = "niri";
}
