{ config, pkgs, ... }:

{
  # --- UTILISATEUR & SHELL ---
  # Utiliser Bash comme shell de login pour compatibilité avec Ly/Hyprland
  # Nushell peut toujours être lancé manuellement depuis Bash
  users.defaultUserShell = pkgs.bash;

  users.users.eldayia = {
    isNormalUser = true;
    description = "Admin";
    extraGroups = [ "networkmanager" "wheel" "video" ]; # "wheel" pour sudo, "video" pour accès GPU
  };
}
