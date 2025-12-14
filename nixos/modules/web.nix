{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # --- NAVIGATEURS WEB ---
    chromium       # Navigateur Chromium (open source)
    microsoft-edge # Microsoft Edge
  ];
}
