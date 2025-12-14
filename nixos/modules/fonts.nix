{ config, pkgs, ... }:

{
  # --- FONTS (Polices) ---
  # Crucial pour que Warp, Hyprland et Fastfetch affichent les icônes
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    font-awesome
  ];
}
