{ config, pkgs, ... }:

{
  # --- SUPPORT VMWARE ---
  # Activer support VMware Guest
  virtualisation.vmware.guest = {
    enable = true;
    headless = false;  # VM avec interface graphique
  };

  # Driver vidéo VMware pour X11
  services.xserver.videoDrivers = [ "vmware" ];

  # Paquets VMware
  environment.systemPackages = with pkgs; [
    open-vm-tools
  ];
}
