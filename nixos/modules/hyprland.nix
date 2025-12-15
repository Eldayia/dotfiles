{ config, pkgs, ... }:

{
  # --- ENVIRONNEMENT GRAPHIQUE (HYPRLAND) ---
  programs.hyprland = {
    enable = true;
    # Force la disponibilité des paquets dans l'environnement
    package = pkgs.hyprland;
    xwayland.enable = true;
  };

  # --- SERVICES ESSENTIELS POUR HYPRLAND ---
  # Polkit (gestion des permissions)
  security.polkit.enable = true;

  # DBUS (communication inter-processus)
  services.dbus.enable = true;

  # Agent polkit graphique
  systemd.user.services.polkit-gnome-authentication-agent-1 = {
    description = "polkit-gnome-authentication-agent-1";
    wantedBy = [ "graphical-session.target" ];
    wants = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
      Restart = "on-failure";
      RestartSec = 1;
      TimeoutStopSec = 10;
    };
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

    # Polkit (authentification graphique)
    polkit_gnome

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
    dbus
  ];

  # Configuration XDG pour les applications
  environment.variables = {
    # Support Qt Wayland avec fallback X11
    QT_QPA_PLATFORM = "wayland;xcb";
    # Désactive le hardcursor pour VM
    WLR_NO_HARDWARE_CURSORS = "1";
    # Support Firefox Wayland
    MOZ_ENABLE_WAYLAND = "1";
    # GTK Wayland avec fallback X11
    GDK_BACKEND = "wayland,x11";
    # Désactiver décorations Qt Wayland
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    # Fix Java applications
    _JAVA_AWT_WM_NONREPARENTING = "1";
    # Support EGL pour Wayland
    EGL_PLATFORM = "wayland";
    # Forcer Mesa software rendering comme fallback si GPU fail
    LIBGL_ALWAYS_SOFTWARE = "0";
  };

  # Services XDG essentiels pour le lancement d'applications
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-hyprland
      xdg-desktop-portal-gtk
    ];
    config.common.default = "*";
  };
}
