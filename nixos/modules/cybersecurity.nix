{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # --- RECONNAISSANCE ---
    naabu          # Scanner de ports rapide
    amass          # Découverte de sous-domaines
    masscan        # Scanner de ports ultra-rapide
    theharvester   # OSINT - collecte d'emails, noms, etc.
    dnsenum        # Énumération DNS
    dnsrecon       # Reconnaissance DNS

    # --- WEB FUZZING & TESTING ---
    ffuf           # Fuzzer web rapide
    httpx          # Sonde HTTP/HTTPS
    burpsuite      # Suite de test d'applications web

    # --- CRACKING & BRUTE FORCE ---
    hydra          # Brute force multi-protocoles
    john           # John the Ripper - crackage de mots de passe
    hashcat        # Crackage de hash GPU/CPU

    # --- ANALYSE RÉSEAU ---
    netcat         # Couteau suisse réseau
    wireshark      # Analyseur de paquets réseau
  ];
}
