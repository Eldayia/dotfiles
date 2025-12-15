{ config, pkgs, ... }:

{
  # --- CONFIGURATION GRAPHIQUE ---
  # Support matériel graphique avec Mesa
  hardware.graphics = {
    enable = true;
    enable32Bit = true;  # Support 32-bit (Wine, Steam, etc.)
  };

  # Activer X11 pour XWayland (nécessaire même en Wayland)
  services.xserver = {
    enable = true;
    # Driver VMware
    videoDrivers = [ "vmware" ];
  };

  # Paquets de diagnostic graphique et support EGL
  environment.systemPackages = with pkgs; [
    mesa-demos  # Tests Mesa (glxgears, glxinfo, etc.)
    vulkan-tools  # Diagnostic Vulkan
    mesa-utils  # Utilitaires Mesa supplémentaires
    egl-wayland  # Support EGL pour Wayland
  ];
}
