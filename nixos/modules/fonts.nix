{ config, pkgs, ... }:

{
  # --- FONTS (Polices) ---
  # Crucial pour que Warp, Hyprland et Fastfetch affichent les icônes
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    font-awesome
    # Polices X11 de base pour xterm
    xorg.fontmiscmisc
    xorg.fontcursormisc
  ];

  # Configuration polices par défaut
  fonts.fontconfig.defaultFonts = {
    monospace = [ "JetBrainsMono Nerd Font" "DejaVu Sans Mono" ];
  };
}
