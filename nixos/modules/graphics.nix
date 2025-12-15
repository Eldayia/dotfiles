{ config, pkgs, ... }:

{
  # --- CONFIGURATION GRAPHIQUE ---
  # Support matériel graphique avec Mesa
  hardware.graphics = {
    enable = true;
    enable32Bit = true;  # Support 32-bit (Wine, Steam, etc.)
  };

  # Driver VMware pour X11/Wayland
  services.xserver.videoDrivers = [ "vmware" ];
}
