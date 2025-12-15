{ config, pkgs, ... }:

{
  # --- UTILISATEUR & SHELL ---
  # Nushell comme shell par défaut
  users.defaultUserShell = pkgs.nushell;

  users.users.eldayia = {
    isNormalUser = true;
    description = "Admin";
    extraGroups = [ "networkmanager" "wheel" "video" ]; # "wheel" pour sudo, "video" pour accès GPU
  };
}
