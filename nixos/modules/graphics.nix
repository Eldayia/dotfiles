{ config, pkgs, ... }:

{
  # --- CONFIGURATION GRAPHIQUE ---
  # Support matériel graphique avec Mesa
  hardware.graphics = {
    enable = true;
    enable32Bit = true;  # Support 32-bit (Wine, Steam, etc.)
  };

  # Paquets de diagnostic graphique
  environment.systemPackages = with pkgs; [
    mesa-demos     # Tests Mesa (glxgears, glxinfo, etc.)
    vulkan-tools   # Diagnostic Vulkan
    xorg.xdpyinfo  # Infos X11
    xorg.xwininfo  # Infos fenêtres X11
  ];
}
