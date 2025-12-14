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

    # Cursors et thèmes
    libxcursor

    # Support pour Wayland (Qt5 et Qt6 avec support Wayland)
    qt5.full
    qt6.full
    libsForQt5.qt5.qtwayland
    kdePackages.qtwayland
  ];

  # Configuration XDG pour les applications
  environment.variables = {
    # Force les applications Qt à utiliser Wayland
    QT_QPA_PLATFORM = "wayland";
    # Désactive le hardcursor pour VM
    WLR_NO_HARDWARE_CURSORS = "1";
  };
}
