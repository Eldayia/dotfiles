{ config, pkgs, ... }:

{
  # --- LOGIN MANAGER : LightDM ---
  # Ly ne semble pas compatible avec i3, utilisation de LightDM à la place
  services.xserver.displayManager.lightdm.enable = true;

  # --- SESSION PAR DÉFAUT : i3 (X11) ---
  # Note: La session par défaut est aussi définie dans modules/x11.nix
  # services.displayManager.defaultSession = "none+i3";
}
