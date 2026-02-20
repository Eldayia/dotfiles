{ config, pkgs, ... }:

{
  # --- NIRI WINDOW MANAGER ---
  # Niri : compositeur Wayland scrollable-tiling basé sur Smithay (pas wlroots)
  # programs.niri.enable gère : package, PAM, session Wayland enregistrée dans Ly
  programs.niri = {
    enable  = true;
    package = pkgs.niri;
  };

  # XWayland rootless (support applications X11 sans serveur X complet)
  # xwayland-satellite intercepte les fenêtres X11 et les intègre dans Niri
  programs.xwayland.enable = true;

  # --- PAQUETS NIRI ESSENTIELS ---
  environment.systemPackages = with pkgs; [
    # XWayland rootless spécifique à Niri
    # (remplace le xwayland standard qui nécessite un serveur X complet)
    xwayland-satellite

    # Notifications Wayland natives
    mako        # Daemon de notifications léger, Wayland-natif
    libnotify   # notify-send (CLI)

    # Clipboard Wayland
    cliphist    # Historique du clipboard avec intégration wofi/rofi
    # wl-clipboard (wl-copy/wl-paste) est dans wayland.nix

    # Fond d'écran animé/statique
    # swaybg est dans wayland.nix

    # Luminosité (touches XF86MonBrightness*)
    brightnessctl

    # Configuration dynamique des outputs (multi-écran, hotplug)
    kanshi

    # Debug/info session Wayland
    wlr-randr   # Équivalent xrandr pour Wayland
  ];

  # --- SERVICE CLIPHIST ---
  # Daemon systemd pour suivre le clipboard en arrière-plan
  # Lance wl-paste et l'envoie à cliphist à chaque copie
  systemd.user.services.cliphist = {
    description = "Clipboard history daemon";
    wantedBy    = [ "graphical-session.target" ];
    partOf      = [ "graphical-session.target" ];
    after       = [ "graphical-session.target" ];
    serviceConfig = {
      ExecStart = "${pkgs.wl-clipboard}/bin/wl-paste --type text --watch ${pkgs.cliphist}/bin/cliphist store";
      Restart   = "on-failure";
    };
  };
}
