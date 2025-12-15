{ config, pkgs, ... }:

{
  # --- GESTION DE SESSION ---
  # dconf nécessaire pour certaines applications GNOME/GTK
  programs.dconf.enable = true;
}
