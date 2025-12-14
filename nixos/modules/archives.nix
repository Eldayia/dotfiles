{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # --- OUTILS DE COMPRESSION & ARCHIVAGE ---
    zip
    unzip
    unp        # Extracteur universel
    p7zip      # Support 7z
  ];
}
