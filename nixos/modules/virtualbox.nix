{ config, pkgs, ... }:

{
  # --- SUPPORT VIRTUALBOX ---
  # Configuration pour VirtualBox Guest (VM)

  # Activer les Guest Additions VirtualBox
  virtualisation.virtualbox.guest = {
    enable = true;
    # Activer la mémoire vidéo étendue et l'accélération 2D/3D
    draganddrop = true;
  };

  # Driver vidéo pour Wayland/X11
  # VirtualBox avec accélération 3D utilise vmsvga + modesetting
  services.xserver = {
    videoDrivers = [ "vmsvga" "modesetting" ];
    # Configuration pour VirtualBox
    deviceSection = ''
      Option "AccelMethod" "glamor"
    '';
  };

  # Variables d'environnement pour améliorer le rendu
  environment.variables = {
    # Forcer l'utilisation de l'accélération matérielle si disponible
    WLR_RENDERER_ALLOW_SOFTWARE = "1";
    # Driver Mesa pour VirtualBox
    MESA_LOADER_DRIVER_OVERRIDE = "vmwgfx";
  };

  # Paquets VirtualBox et drivers graphiques
  environment.systemPackages = with pkgs; [
    # Guest Additions déjà inclus via virtualisation.virtualbox.guest
    # Drivers Mesa pour vmwgfx (VirtualBox/VMware)
    mesa
    libGL
    libdrm
  ];

  # Modules kernel pour VirtualBox graphics
  boot.kernelModules = [ "vmwgfx" ];
}
