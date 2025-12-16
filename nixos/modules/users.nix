{ config, pkgs, ... }:

{
  # --- UTILISATEUR & SHELL ---
  # Nushell comme shell par défaut
  users.defaultUserShell = pkgs.nushell;

  users.users.eldayia = {
    isNormalUser = true;
    description = "Admin";
    extraGroups = [ "networkmanager" "wheel" "video" "render" "input" ]; # Groupes pour accès GPU et périphériques
  };
}
