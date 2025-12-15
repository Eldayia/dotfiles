{ config, pkgs, ... }:

{
  # --- LOGICIELS PROPRIÉTAIRES ---
  # Nécessaire pour certains logiciels (navigateurs, etc.)
  nixpkgs.config.allowUnfree = true;

  # --- PAQUETS ENVIRONNEMENT GRAPHIQUE ---
  # Paquets pour l'environnement graphique X11 + i3
  # Note: Les applications d'interface (wofi, waybar, rofi, etc.) sont dans interface.nix
  environment.systemPackages = with pkgs; [
    # Terminaux
    warp-terminal  # Terminal principal (moderne, AI-powered)
    kitty          # Terminal secondaire (GPU-accelerated)
    # ghostty est dans terminal-utils.nix

    # Notifications
    dunst          # Gestionnaire de notifications (X11 et Wayland)

    # Clipboard X11
    xclip          # Clipboard X11 (xclip -selection clipboard)
  ];
}
