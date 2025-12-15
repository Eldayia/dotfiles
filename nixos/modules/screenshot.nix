{ config, pkgs, ... }:

{
  # --- OUTILS DE CAPTURE D'ÉCRAN WAYLAND ---
  environment.systemPackages = with pkgs; [
    grim           # Capture d'écran Wayland
    slurp          # Sélection de zone d'écran
    swappy         # Annotation de screenshots
  ];
}
