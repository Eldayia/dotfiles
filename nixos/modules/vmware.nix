{ config, pkgs, ... }:

{
  # --- SUPPORT VMWARE ---
  # Activer support VMware Guest
  virtualisation.vmware.guest = {
    enable = true;
    headless = false;  # VM avec interface graphique
  };

  # Driver vidéo pour X11
  # Note: "modesetting" est plus stable que "vmware" dans certains cas
  # Essayer "vmware" si modesetting ne fonctionne pas
  services.xserver.videoDrivers = [ "modesetting" ];

  # Paquets VMware
  environment.systemPackages = with pkgs; [
    open-vm-tools
  ];
}
