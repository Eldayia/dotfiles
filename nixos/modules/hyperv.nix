{ config, pkgs, ... }:

{
  # --- SUPPORT HYPER-V AVEC GPU-PV ---
  # Hyper-V Guest avec accélération GPU Intel (GPU Paravirtualization)
  # Le GPU hôte Intel est exposé à la VM via le protocole Hyper-V GPU-PV

  # Services et modules kernel Hyper-V Guest
  virtualisation.hypervGuest.enable = true;

  # --- DRIVERS GPU INTEL (GPU-PV) ---
  hardware.graphics = {
    enable      = true;
    enable32Bit = true;  # Wine, Steam, applications 32-bit

    extraPackages = with pkgs; [
      # VA-API (accélération vidéo matérielle)
      intel-media-driver    # Driver iHD - Gen8+ (recommandé, UHD/Iris/Arc)
      intel-vaapi-driver    # Driver i965 - Gen2-Gen9 (legacy, fallback)

      # VDPAU (API NVIDIA implémentée par-dessus VA-API/OpenGL)
      libva-vdpau-driver    # Bridge VA-API → VDPAU
      libvdpau-va-gl        # Implémente VDPAU via OpenGL

      # OpenCL Intel (calcul GPU général)
      intel-compute-runtime
    ];
  };

  # --- MODULES KERNEL ---
  # i915  : driver DRM/KMS Intel iGPU (Gen2→Gen12, GPU-PV)
  # hv_*  : modules Hyper-V Guest (vmbus, stockage, réseau, utilitaires)
  boot.kernelModules = [
    "i915"
    "hv_vmbus"
    "hv_storvsc"
    "hv_netvsc"
    "hv_utils"
  ];

  # --- VARIABLES DE SESSION ---
  # Visibles uniquement dans les sessions graphiques (display manager)
  environment.sessionVariables = {
    LIBVA_DRIVER_NAME   = "iHD";   # Force le driver Intel moderne pour VA-API
    XDG_CURRENT_DESKTOP = "niri";  # Requis pour la sélection du portail XDG GTK
  };

  # --- VARIABLES D'ENVIRONNEMENT GLOBALES ---
  environment.variables = {
    # Curseur hardware désactivé (instable sur Hyper-V GPU-PV)
    WLR_NO_HARDWARE_CURSORS     = "1";
    # Direct scanout désactivé (le GPU-PV Hyper-V ne supporte pas le scanout DRM)
    NIRI_DISABLE_DIRECT_SCANOUT = "1";
    # Vulkan ICD Intel (ANV via Mesa)
    VK_DRIVER_FILES = "/run/opengl-driver/share/vulkan/icd.d/intel_icd.x86_64.json";
  };

  # Driver Xorg/KMS (utilisé par Ly pour initialiser le KMS avant Wayland)
  services.xserver.videoDrivers = [ "modesetting" ];

  # --- PAQUETS DE RENDU ET DIAGNOSTIC GPU ---
  environment.systemPackages = with pkgs; [
    # OpenGL / EGL
    mesa     # Mesa OpenGL + DRI drivers (iris/i965) + Vulkan ANV Intel
    libGL    # Wrapper libGL → Mesa

    # Diagnostic
    mesa-demos        # glxgears, glxinfo, eglinfo
    vulkan-tools      # vulkaninfo, vkcube
    intel-gpu-tools   # intel_gpu_top, igt-gpu-tools
    libva-utils       # vainfo (vérification VA-API)

    # Loaders / layers
    vulkan-loader             # Chargeur Vulkan ICD
    vulkan-validation-layers  # Couches de validation Vulkan (debug)
  ];
}
