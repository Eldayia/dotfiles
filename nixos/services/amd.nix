{ config, pkgs, ... }:

{
  # Configuration pour cartes graphiques AMD
  # À activer pour bare metal avec GPU AMD (Radeon)

  # Activer les pilotes AMD open-source (AMDGPU)
  services.xserver.videoDrivers = [ "amdgpu" ];

  # Configuration matérielle AMD
  hardware.amdgpu = {
    # Activer support OpenCL (pour calcul GPU)
    opencl.enable = true;

    # Activer AMDVLK (pilote Vulkan AMD officiel)
    # Alternative : utiliser Mesa RADV (pilote Vulkan open-source)
    # amdvlk.enable = true;
    # amdvlk.support32Bit.enable = true;  # Support 32-bit pour jeux
  };

  # Support Vulkan avec Mesa (pilote open-source RADV)
  hardware.graphics = {
    enable = true;
    enable32Bit = true;  # Support 32-bit pour jeux et applications legacy

    extraPackages = with pkgs; [
      # Pilotes Mesa pour AMD
      mesa.drivers

      # Support VAAPI (accélération vidéo)
      vaapiVdpau
      libvdpau-va-gl

      # Support AMD pour décodage/encodage vidéo
      # rocm-opencl-icd      # OpenCL AMD (ROCm)
      # rocm-opencl-runtime  # Runtime OpenCL AMD
    ];

    extraPackages32 = with pkgs.driversi686Linux; [
      mesa.drivers
      vaapiVdpau
      libvdpau-va-gl
    ];
  };

  # Variables d'environnement pour AMD
  environment.sessionVariables = {
    # Force l'utilisation du pilote RADV (Mesa) pour Vulkan
    AMD_VULKAN_ICD = "RADV";

    # Variables pour Wayland/Hyprland
    # WLR_NO_HARDWARE_CURSORS = "1";  # Décommenter si problèmes de curseur
  };

  # Paquets additionnels utiles
  environment.systemPackages = with pkgs; [
    nvtopPackages.amd  # Moniteur GPU (comme htop pour AMD)
    # radeontop          # Moniteur GPU AMD alternatif
    # glxinfo            # Info OpenGL
    # vulkan-tools       # Outils Vulkan
    # clinfo             # Info OpenCL
  ];

  # Configuration du noyau (optionnel)
  # boot.kernelParams = [
  #   # Activer support early KMS (kernel mode setting)
  #   "amdgpu.dc=1"
  #   # Activer FreeSync
  #   "amdgpu.freesync=1"
  # ];

  # Charger le module AMDGPU au démarrage
  boot.initrd.kernelModules = [ "amdgpu" ];
}
