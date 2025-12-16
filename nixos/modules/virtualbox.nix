{ config, pkgs, ... }:

{
  # --- SUPPORT VIRTUALBOX ---
  # Configuration pour VirtualBox Guest (VM)

  # Activer les Guest Additions VirtualBox
  virtualisation.virtualbox.guest = {
    enable = true;
    # Support X11 (copier-coller, redimensionnement fenêtre)
    x11 = true;
  };

  # Driver vidéo pour Wayland/X11
  # VirtualBox utilise bien "modesetting" pour Wayland
  services.xserver.videoDrivers = [ "modesetting" ];

  # Paquets VirtualBox
  environment.systemPackages = with pkgs; [
    # Guest Additions déjà inclus via virtualisation.virtualbox.guest
  ];
}
