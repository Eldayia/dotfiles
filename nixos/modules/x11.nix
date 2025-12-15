{ config, pkgs, ... }:

{
  # --- CONFIGURATION X11 ---
  # Configuration du serveur X11 pour environnement graphique

  # Activer le serveur X11
  services.xserver = {
    enable = true;

    # Clavier
    xkb = {
      layout = "fr";
      variant = "";
    };

    # Window Manager - i3
    windowManager.i3 = {
      enable = true;
      # Les paquets i3 sont dans interface.nix (i3status, i3lock, i3blocks)
      extraPackages = with pkgs; [
        dmenu  # Lanceur d'applications spécifique i3
      ];
    };
  };

  # Désactiver le touchpad par défaut (VM)
  services.libinput.enable = false;

  # Configuration d'affichage (session par défaut)
  services.displayManager.defaultSession = "none+i3";

  # Paquets spécifiques X11
  # Note: Les applications d'interface communes sont dans interface.nix
  environment.systemPackages = with pkgs; [
    # Utilitaires X11 purs
    xorg.xrandr     # Gestion de l'affichage
    xorg.xev        # Événements clavier/souris
    # dmenu est déjà dans windowManager.i3.extraPackages
  ];

  # Variables d'environnement pour X11
  environment.variables = {
    # Support Qt avec X11
    QT_QPA_PLATFORM = "xcb";
    # GTK utilise X11
    GDK_BACKEND = "x11";
    # Accélération matérielle (si disponible)
    LIBGL_ALWAYS_SOFTWARE = "0";
  };
}
