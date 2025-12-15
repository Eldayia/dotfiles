{ config, pkgs, lib, ... }:

{
  # --- CONFIGURATION WSL2 ---
  # Module pour NixOS sur WSL2 (Windows Subsystem for Linux)

  # Importer le module NixOS-WSL
  # Note: Nécessite d'ajouter nixos-wsl dans les inputs du flake
  # ou d'installer manuellement

  wsl = {
    enable = true;
    defaultUser = "eldayia";
    startMenuLaunchers = true;

    # Support de systemd (requis pour Hyprland)
    nativeSystemd = true;

    # Montages Windows
    wslConf.automount.root = "/mnt";

    # Intégration Windows
    wslConf.network.generateHosts = true;
    wslConf.network.generateResolvConf = true;

    # WSLg (support graphique)
    # Permet d'exécuter des applications graphiques Linux depuis Windows
    useWindowsDriver = true;
  };

  # Variables d'environnement pour WSLg
  environment.variables = {
    # Display pour WSLg
    DISPLAY = ":0";
    WAYLAND_DISPLAY = "wayland-0";

    # Support XWayland
    XDG_RUNTIME_DIR = "/run/user/1000";

    # Curseur Wayland
    WLR_NO_HARDWARE_CURSORS = "1";
  };

  # Services graphiques pour WSL2
  # Note: Le display server X11/Wayland est géré par WSLg
  services.xserver.enable = lib.mkForce false;  # WSLg gère l'affichage

  # Réseau WSL2
  networking.dhcpcd.enable = false;  # WSL2 gère le réseau

  # Ne pas gérer le boot (géré par Windows)
  boot.loader.systemd-boot.enable = lib.mkForce false;
  boot.loader.grub.enable = lib.mkForce false;
}
