{ config, pkgs, ... }:

{
  # --- HYPRLAND WINDOW MANAGER ---
  # Configuration minimale pour Hyprland (Wayland compositor)
  programs.hyprland = {
    enable = true;
    package = pkgs.hyprland;
    xwayland.enable = true;
  };

  # Paquets Hyprland essentiels
  environment.systemPackages = with pkgs; [
    hyprland
    xwayland
  ];
}
