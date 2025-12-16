{ config, pkgs, ... }:

{
  # Configuration pour cartes graphiques Intel
  # À activer pour bare metal avec GPU Intel intégré

  # Activer les pilotes Intel open-source
  services.xserver.videoDrivers = [ "modesetting" ];  # Pilote moderne (recommandé)
  # services.xserver.videoDrivers = [ "intel" ];      # Ancien pilote (pour GPU plus anciens)

  # Configuration matérielle Intel
  hardware.graphics = {
    enable = true;
    enable32Bit = true;  # Support 32-bit pour jeux et applications legacy

    extraPackages = with pkgs; [
      # Pilotes Mesa pour Intel
      intel-media-driver    # Nouveau pilote VAAPI (Broadwell et plus récent)
      intel-vaapi-driver    # Ancien pilote VAAPI (pour GPU plus anciens)

      # Support Vulkan
      intel-compute-runtime  # OpenCL pour Intel

      # Support VDPAU
      vaapiVdpau
      libvdpau-va-gl
    ];

    extraPackages32 = with pkgs.driversi686Linux; [
      intel-media-driver
      intel-vaapi-driver
      vaapiVdpau
      libvdpau-va-gl
    ];
  };

  # Variables d'environnement pour Intel
  environment.sessionVariables = {
    # Force l'utilisation du nouveau pilote VAAPI
    LIBVA_DRIVER_NAME = "iHD";  # Pour intel-media-driver (Gen 8+)
    # LIBVA_DRIVER_NAME = "i965";  # Pour intel-vaapi-driver (Gen 4-9)

    # Variables pour Wayland/Hyprland (rarement nécessaire pour Intel)
    # WLR_NO_HARDWARE_CURSORS = "1";  # Décommenter si problèmes de curseur
  };

  # Paquets additionnels utiles
  environment.systemPackages = with pkgs; [
    intel-gpu-tools  # Outils de diagnostic Intel GPU (intel_gpu_top, etc.)
    # nvtopPackages.intel  # Moniteur GPU (comme htop pour Intel)
    # glxinfo              # Info OpenGL
    # vulkan-tools         # Outils Vulkan
    # clinfo               # Info OpenCL
  ];

  # Configuration du noyau (optionnel)
  # boot.kernelParams = [
  #   # Activer GuC/HuC firmware (améliore performances sur Gen 9+)
  #   "i915.enable_guc=2"
  #   # Activer Panel Self Refresh (économie d'énergie pour laptops)
  #   "i915.enable_psr=1"
  #   # Activer Framebuffer Compression (économie d'énergie)
  #   "i915.enable_fbc=1"
  # ];

  # Charger le module i915 au démarrage avec early KMS
  boot.initrd.kernelModules = [ "i915" ];

  # Configuration spécifique pour ancien pilote Intel (si utilisé)
  # services.xserver.deviceSection = ''
  #   Option "DRI" "3"
  #   Option "TearFree" "true"
  # '';
}
