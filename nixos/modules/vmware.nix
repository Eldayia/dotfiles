{ config, pkgs, ... }:

{
  # --- SUPPORT VMWARE ---
  # Activer support VMware Guest
  virtualisation.vmware.guest = {
    enable = true;
    headless = false;  # VM avec interface graphique
  };

  # Paquets VMware
  environment.systemPackages = with pkgs; [
    open-vm-tools
  ];
}
