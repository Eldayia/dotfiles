{ config, pkgs, ... }:

{
  # --- SUPPORT HYPER-V AVEC GPU-PV ---
  # Configuration pour Hyper-V Guest avec accélération GPU Intel (GPU-PV)

  # Activer les services Hyper-V Guest
  # Note: videoMode est déprécié, configurer via Hyper-V Settings
  virtualisation.hypervGuest.enable = true;

  # Support GPU Intel pour GPU-PV
  # Note: driSupport est déprécié dans NixOS 24.11+
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      intel-media-driver    # Pour Intel Arc/iGPU (driver moderne)
      intel-vaapi-driver    # Support VA-API legacy (anciennement vaapiIntel)
      vaapiVdpau            # Bridge VA-API vers VDPAU
      libvdpau-va-gl        # VDPAU via OpenGL
      intel-compute-runtime # Support OpenCL Intel
    ];
  };

  # Modules kernel pour le GPU Intel
  boot.kernelModules = [ "i915" "hv_vmbus" "hv_storvsc" "hv_netvsc" "hv_utils" ];

  # Variables d'environnement pour l'accélération matérielle
  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "iHD";  # Driver Intel moderne (pour Arc/Gen12+)
  };

  # Variables d'environnement pour Wayland sur Hyper-V
  environment.variables = {
    # Pas de curseur hardware (plus stable sur VM)
    WLR_NO_HARDWARE_CURSORS = "1";
  };

  # Driver vidéo modesetting (fonctionne avec i915)
  services.xserver.videoDrivers = [ "modesetting" ];

  # Paquets pour le rendu graphique et diagnostic GPU
  environment.systemPackages = with pkgs; [
    # Rendu OpenGL
    mesa
    libGL

    # Outils de diagnostic GPU
    glxinfo
    vulkan-tools
    mesa-demos
    intel-gpu-tools

    # Vulkan Intel
    vulkan-loader
  ];
}
