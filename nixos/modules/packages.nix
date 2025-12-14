{ config, pkgs, ... }:

{
  # --- LOGICIELS PROPRIÉTAIRES ---
  # Nécessaire pour certains logiciels (navigateurs, etc.)
  nixpkgs.config.allowUnfree = true;

  # --- PAQUETS HYPRLAND / WAYLAND ---
  # Paquets spécifiques à l'environnement Hyprland
  environment.systemPackages = with pkgs; [
    warp-terminal  # Terminal principal
    kitty          # Terminal de secours
    wofi           # Lanceur d'applications (menu)
    waybar         # Barre d'état
    dunst          # Notifications
  ];
}
