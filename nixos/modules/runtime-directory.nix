{ config, pkgs, ... }:

{
  # --- CONFIGURATION XDG_RUNTIME_DIR ---
  # Nécessaire pour Wayland/Hyprland

  # Activer la gestion automatique des répertoires runtime
  services.logind = {
    extraConfig = "RuntimeDirectorySize=1G";
  };

  # Créer le répertoire au démarrage si nécessaire
  systemd.tmpfiles.rules = [
    "d /run/user 0755 root root -"
  ];
}
