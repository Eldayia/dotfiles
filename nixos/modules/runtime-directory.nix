{ config, pkgs, ... }:

{
  # --- CONFIGURATION XDG_RUNTIME_DIR ---
  # Nécessaire pour Wayland/Hyprland

  # Activer la gestion automatique des répertoires runtime
  services.logind.extraConfig = ''
    RuntimeDirectorySize=1G
  '';

  # S'assurer que pam_systemd est activé (crée /run/user/$UID)
  security.pam.services.login.enableGnomeKeyring = false;
  security.pam.loginLimits = [];

  # Créer le répertoire au démarrage si nécessaire
  systemd.tmpfiles.rules = [
    "d /run/user 0755 root root -"
  ];
}
