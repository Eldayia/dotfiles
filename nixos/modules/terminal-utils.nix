{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # --- TERMINAL EMULATORS ---
    ghostty        # Terminal moderne et rapide

    # --- MONITORING SYSTÈME ---
    btop           # Moniteur de ressources moderne
    glances        # Dashboard de monitoring
    iotop          # Monitoring I/O disque
    dool           # Alternative à dstat
    procs          # Alternative moderne à ps
    lsof           # Liste les fichiers ouverts

    # --- INFORMATIONS SYSTÈME ---
    fastfetch      # Info système rapide et stylé
    lsb-release    # Informations sur la distribution

    # --- SHELL & PROMPT ---
    starship       # Prompt shell moderne et rapide

    # --- PRODUCTIVITÉ ---
    stow           # Gestionnaire de symlinks pour dotfiles
    direnv         # Chargement automatique d'environnements
    tree           # Affichage d'arborescence
    libnotify      # Notifications desktop

    # --- NAVIGATION & RECHERCHE ---
    fzf            # Fuzzy finder
    ripgrep        # Grep ultra-rapide
    fd             # Alternative moderne à find
    zoxide         # CD intelligent

    # --- FILE MANAGERS ---
    yazi           # File manager en terminal

    # --- VISUALISATION ---
    bat            # Cat avec coloration syntaxique
    eza            # Alternative moderne à ls

    # --- STOCKAGE ---
    ncdu           # Analyseur d'espace disque
    dysk           # Informations sur les disques

    # --- RECORDING & DEMO ---
    asciinema      # Enregistrement de sessions terminal
    asciinema-agg  # Générateur de GIFs depuis asciinema

    # --- DOCUMENTATION ---
    tldr           # Pages de manuel simplifiées

    # --- SHELL HISTORY ---
    atuin          # Historique de commandes amélioré

    # --- MULTIPLEXEURS ---
    zellij         # Multiplexeur de terminal moderne

    # --- UTILITAIRES ---
    pay-respects   # Alternative moderne à thefuck
    progress       # Visualisation de la progression de commandes
  ];
}
