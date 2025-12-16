{ config, pkgs, ... }:

{
  # --- SUPPORT VIRTUALBOX ---
  # Configuration pour VirtualBox Guest (VM)

  # Activer les Guest Additions VirtualBox
  virtualisation.virtualbox.guest = {
    enable = true;
    draganddrop = true;
  };

  # Driver vidéo simple pour VirtualBox
  # modesetting fonctionne mieux avec Wayland sur VirtualBox
  services.xserver.videoDrivers = [ "modesetting" ];

  # Variables d'environnement pour Wayland sur VirtualBox
  environment.variables = {
    # Permet le rendu software comme fallback
    WLR_RENDERER_ALLOW_SOFTWARE = "1";
    # Disable hardware cursors (obligatoire pour VirtualBox)
    WLR_NO_HARDWARE_CURSORS = "1";
  };

  # Paquets pour le rendu graphique
  environment.systemPackages = with pkgs; [
    mesa
    libGL
  ];
}
