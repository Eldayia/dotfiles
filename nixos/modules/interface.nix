{ config, pkgs, ... }:

{
  # --- APPLICATIONS D'INTERFACE GRAPHIQUE ---
  # Applications et services communs à tous les environnements graphiques
  # (X11, Wayland, Hyprland, i3, etc.)

  # --- SERVICES ESSENTIELS ---
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

  # --- APPLICATIONS D'INTERFACE ---
  environment.systemPackages = with pkgs; [
    # Lanceurs d'applications
    wofi      # Lanceur Wayland
    rofi      # Lanceur X11/Wayland

    # Barres d'état
    waybar    # Barre d'état Wayland
    i3status  # Barre d'état i3/X11
    i3blocks  # Barre d'état i3 alternative

    # Gestionnaire de fichiers
    nautilus  # Gestionnaire de fichiers GNOME

    # Polkit (authentification graphique)
    polkit_gnome

    # Utilitaires graphiques
    feh            # Visualiseur d'images / fond d'écran
    picom          # Compositeur X11 (transparence, ombres)
    arandr         # Configuration écrans (GUI pour xrandr)
    lxappearance   # Configuration thèmes GTK
    # pavucontrol est dans multimedia.nix

    # Verrouillage d'écran
    i3lock         # Écran de verrouillage i3

    # Bibliothèques graphiques essentielles
    glib
    gtk3
    gtk4
    libnotify
    xdg-utils
    shared-mime-info
    gsettings-desktop-schemas
    dbus
  ];
}
