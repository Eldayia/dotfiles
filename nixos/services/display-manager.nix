{ config, pkgs, ... }:

{
  # --- LOGIN MANAGER : LY ---
  services.displayManager.ly.enable = true;

  # --- SESSION PAR DÉFAUT : i3 (X11) ---
  # Note: La session par défaut est aussi définie dans modules/x11.nix
  # services.displayManager.defaultSession = "none+i3";
}
