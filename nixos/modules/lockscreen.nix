{ config, pkgs, ... }:

{
  # --- VERROUILLAGE D'ÉCRAN WAYLAND ---
  environment.systemPackages = with pkgs; [
    swaylock-effects  # Écran de verrouillage avec effets
    swayidle          # Gestion de l'inactivité
  ];

  # Configuration PAM pour swaylock
  security.pam.services.swaylock = {};
}
