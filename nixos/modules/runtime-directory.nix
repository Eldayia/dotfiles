{ config, pkgs, ... }:

{
  # --- CONFIGURATION XDG_RUNTIME_DIR ---
  # Nécessaire pour Wayland/Hyprland

  # systemd-logind crée automatiquement /run/user/$UID sur NixOS
  # Ce module assure juste que le service est activé

  services.logind.enable = true;
}
