{ config, pkgs, ... }:

{
  imports =
    [
      # Configuration matérielle
      ./hardware-configuration.nix

      # Modules système de base
      ./modules/boot.nix
      ./modules/network.nix
      ./modules/locale.nix
      ./modules/users.nix
      ./modules/fonts.nix

      # Environnement graphique
      ./modules/hyprland.nix
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

      # Services
      ./services/audio.nix
      ./services/display-manager.nix
    ];

  # Version de l'état (Ne pas toucher)
  system.stateVersion = "24.05";
}