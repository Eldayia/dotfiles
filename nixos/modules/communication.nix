{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # --- COMMUNICATION ---
    vesktop    # Discord client amélioré (open source)
  ];
}
