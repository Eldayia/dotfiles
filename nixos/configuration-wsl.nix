{ config, pkgs, ... }:

{
  # --- CONFIGURATION NIXOS POUR WSL2 ---
  # Version adaptée pour Windows Subsystem for Linux 2

  imports =
    [
      # Configuration matérielle WSL2 (à générer)
      ./hardware-configuration.nix

      # Module WSL2 spécifique
      ./modules/wsl.nix

      # Modules système de base
      ./modules/network.nix
      ./modules/locale.nix
      ./modules/users.nix
      ./modules/fonts.nix
      ./modules/graphics.nix
      ./modules/session.nix

      # Environnement graphique (Wayland/Hyprland via WSLg)
      ./modules/wayland.nix     # Configuration Wayland pure
      ./modules/hyprland.nix    # Hyprland window manager
      ./modules/interface.nix   # Applications d'interface
      ./modules/packages.nix

      # Applications par catégorie
      ./modules/archives.nix
      ./modules/communication.nix
      ./modules/cybersecurity.nix
      ./modules/development.nix
      ./modules/multimedia.nix
      ./modules/network-tools.nix
      ./modules/terminal-utils.nix
      ./modules/web.nix
      ./modules/screenshot.nix
      ./modules/lockscreen.nix

      # Services
      ./services/audio.nix
      # Note: pas de display-manager sur WSL2 (géré par WSLg)
      ./services/ssh.nix
    ];

  # Version de l'état (Ne pas toucher)
  system.stateVersion = "24.05";
}
