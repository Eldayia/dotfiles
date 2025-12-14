{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # --- AUDIO ---
    playerctl      # Contrôle de lecture média
    pavucontrol    # Contrôle de volume PulseAudio/Pipewire
    pulsemixer     # Mixeur audio en CLI

    # --- VIDÉO ---
    vlc            # Lecteur vidéo universel

    # --- GRAPHISME ---
    gimp           # Éditeur d'images

    # --- TÉLÉCHARGEMENT ---
    qbittorrent    # Client BitTorrent
  ];
}
