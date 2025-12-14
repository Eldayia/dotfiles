{ config, pkgs, ... }:

{
  # --- UTILISATEUR & SHELL ---
  # On définit Nushell comme shell par défaut ici
  users.defaultUserShell = pkgs.nushell;

  users.users.eldayia = {
    isNormalUser = true;
    description = "Admin";
    extraGroups = [ "networkmanager" "wheel" ]; # "wheel" pour sudo
    # Pas besoin de définir shell ici si defaultUserShell est mis
  };
}
