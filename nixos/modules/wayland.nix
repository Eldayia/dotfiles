{ config, pkgs, ... }:

{
  # --- CONFIGURATION WAYLAND PURE ---
  # Uniquement les bibliothèques et protocoles Wayland de base
  # Pour les applications d'interface, voir interface.nix

  # --- PAQUETS WAYLAND PURS ---
  environment.systemPackages = with pkgs; [
    # Protocoles et bibliothèques Wayland
    wlroots            # Bibliothèque pour compositeurs Wayland
    wayland-protocols  # Protocoles Wayland standards
    wayland-utils      # Utilitaires Wayland (wayland-info, etc.)
    wl-clipboard       # Clipboard Wayland (wl-copy, wl-paste)
    swaybg             # Wallpaper pour Wayland

    # Support Qt pour Wayland
    libsForQt5.qt5.qtwayland
    kdePackages.qtwayland
    qt6.qtwayland

    # Cursors
    libxcursor
  ];

  # --- VARIABLES D'ENVIRONNEMENT WAYLAND ---
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
  };

  # --- XDG DESKTOP PORTAL ---
  # Note: xdg-desktop-portal-wlr est pour wlroots (Sway) uniquement, PAS pour Niri (Smithay)
  # Niri gère Screenshot/Screencast via son propre IPC — pas besoin de portal wlr
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk        # Portail générique GTK (file picker, etc.)
      # xdg-desktop-portal-hyprland # OPTIONNEL si retour sur Hyprland
    ];
    config = {
      niri = {
        default = [ "gtk" ];
      };
      common = {
        default = [ "gtk" ];
      };
    };
  };
}
