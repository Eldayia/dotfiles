{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # --- TÉLÉCHARGEMENT ---
    wget           # Téléchargeur en ligne de commande
    curl           # Transfert de données avec URLs

    # --- DNS ---
    dnsmasq        # Serveur DNS/DHCP léger
    dog            # Client DNS moderne (alternative à dig)

    # --- SCAN & ANALYSE ---
    nmap           # Scanner de réseau et ports

    # --- HTTP ---
    httpie         # Client HTTP convivial

    # --- MONITORING ---
    mtr            # Combinaison de ping et traceroute
    mosh           # SSH mobile avec roaming

    # --- UTILITAIRES ---
    ipcalc         # Calculateur de sous-réseaux
    openssl        # Outils cryptographiques et SSL/TLS
  ];
}
