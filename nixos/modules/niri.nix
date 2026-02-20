{ config, pkgs, ... }:

{
  # --- NIRI WINDOW MANAGER ---
  # Configuration pour Niri (Wayland compositor scrollable tiling)
  programs.niri = {
    enable = true;
    package = pkgs.niri;
  };

  # Paquets Niri essentiels
  environment.systemPackages = with pkgs; [
    niri
    xwayland       # Support applications X11
    alacritty      # Terminal recommandé par Niri
  ];

  # XWayland pour compatibilité applications X11
  programs.xwayland.enable = true;
}
