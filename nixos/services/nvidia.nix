{ config, pkgs, ... }:

{
  # Configuration pour cartes graphiques Nvidia
  # À activer pour bare metal avec GPU Nvidia

  # Activer les pilotes propriétaires Nvidia
  services.xserver.videoDrivers = [ "nvidia" ];

  # Configuration du pilote Nvidia
  hardware.nvidia = {
    # Utiliser le pilote propriétaire (recommandé)
    # Utiliser `false` pour le pilote open-source (expérimental)
    open = false;

    # Activer les paramètres Nvidia
    nvidiaSettings = true;

    # Choisir la version du pilote
    # Pour la version stable :
    package = config.boot.kernelPackages.nvidiaPackages.stable;

    # Pour la version beta (dernières fonctionnalités) :
    # package = config.boot.kernelPackages.nvidiaPackages.beta;

    # Pour les anciennes cartes (série 600/700) :
    # package = config.boot.kernelPackages.nvidiaPackages.legacy_470;

    # Activer modesetting (recommandé pour Wayland)
    modesetting.enable = true;

    # Activer Power Management (pour laptops)
    powerManagement.enable = false;
    powerManagement.finegrained = false;

    # Prime (pour laptops avec GPU hybride Intel + Nvidia)
    # Décommenter et configurer si nécessaire
    # prime = {
    #   # Synchronisation (utilise le GPU Nvidia tout le temps)
    #   sync.enable = true;
    #
    #   # Offload (utilise Intel par défaut, Nvidia sur demande)
    #   # offload.enable = true;
    #   # offload.enableOffloadCmd = true;
    #
    #   # Bus IDs (trouver avec : lspci | grep -E "VGA|3D")
    #   intelBusId = "PCI:0:2:0";
    #   nvidiaBusId = "PCI:1:0:0";
    # };
  };

  # Variables d'environnement pour Wayland/Hyprland
  environment.sessionVariables = {
    # Force l'utilisation du GPU Nvidia
    WLR_NO_HARDWARE_CURSORS = "1";  # Fix pour curseurs sur Nvidia
    # __GLX_VENDOR_LIBRARY_NAME = "nvidia";  # Décommenter si nécessaire
    # GBM_BACKEND = "nvidia-drm";            # Décommenter pour Wayland natif
  };

  # Paquets additionnels utiles
  environment.systemPackages = with pkgs; [
    nvtopPackages.nvidia  # Moniteur GPU (comme htop pour Nvidia)
    # glxinfo                # Info OpenGL
    # vulkan-tools           # Outils Vulkan
  ];
}
