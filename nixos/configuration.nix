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
      # ./modules/vmware.nix      # VMware Guest - OPTIONNEL
      ./modules/virtualbox.nix    # VirtualBox Guest - ACTIF
      # ./modules/wsl.nix         # WSL2 - OPTIONNEL (utiliser configuration-wsl.nix)
      ./modules/graphics.nix
      ./modules/session.nix

      # Environnement graphique
      # ./modules/x11.nix       # Configuration X11 + i3 - OPTIONNEL
      ./modules/wayland.nix     # Configuration Wayland pure (protocoles, libs) - ACTIF
      ./modules/hyprland.nix    # Hyprland window manager - ACTIF
      ./modules/interface.nix   # Applications d'interface (wofi, waybar, etc.)
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
      ./services/display-manager.nix
      ./services/ssh.nix
    ];

  # Version de l'état (Ne pas toucher)
  system.stateVersion = "24.05";
}