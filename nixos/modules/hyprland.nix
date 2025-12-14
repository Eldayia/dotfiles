{ config, pkgs, ... }:

{
  # --- ENVIRONNEMENT GRAPHIQUE (HYPRLAND) ---
  programs.hyprland = {
    enable = true;
    # Force la disponibilité des paquets dans l'environnement
    package = pkgs.hyprland;
  };

  # --- PAQUETS GRAPHIQUES REQUIS PAR HYPRLAND ---
  # Ces paquets doivent être disponibles au système pour Hyprland
  environment.systemPackages = with pkgs; [
    # Paquets Hyprland essentiels
    hyprland
    xwayland
    wlroots
    wayland-protocols
    wayland-utils

    # Cursors et thèmes
    libxcursor

    # Gestionnaire de fichiers
    nautilus

    # Support pour Wayland (Qt5 et Qt6 avec support Wayland)
    libsForQt5.qt5.qtwayland
    kdePackages.qtwayland
    qt6.qtwayland

    # Bibliothèques essentielles pour lancer les applications
    glib
    gtk3
    gtk4
    libnotify
    xdg-utils
    shared-mime-info
    gsettings-desktop-schemas
  ];

  # Configuration XDG pour les applications
  environment.variables = {
    # Force les applications Qt à utiliser Wayland
    QT_QPA_PLATFORM = "wayland";
    # Désactive le hardcursor pour VM
    WLR_NO_HARDWARE_CURSORS = "1";
  };

  # Services XDG essentiels pour le lancement d'applications
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    config.common.default = "*";
  };
}
