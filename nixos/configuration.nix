{ config, pkgs, ... }:

{
  imports =
    [ # Inclut les résultats du scan matériel
      ./hardware-configuration.nix
    ];

  # --- 1. BOOTLOADER (UEFI) ---
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # --- 2. RÉSEAU ---
  networking.hostName = "nixos-hypr"; # Nom de la machine
  networking.networkmanager.enable = true; # Gestionnaire réseau simple

  # --- 3. LOCALISATION ---
  time.timeZone = "Europe/Paris";
  i18n.defaultLocale = "fr_FR.UTF-8";
  console.keyMap = "fr";

  # --- 4. UTILISATEUR & SHELL ---
  # On définit Nushell comme shell par défaut ici
  users.defaultUserShell = pkgs.nushell;
  
  users.users.eldayia = {
    isNormalUser = true;
    description = "Admin";
    extraGroups = [ "networkmanager" "wheel" ]; # "wheel" pour sudo
    # Pas besoin de définir shell ici si defaultUserShell est mis
  };

  # --- 5. LOGICIELS PROPRIÉTAIRES ---
  # Nécessaire pour Warp Terminal, Chrome, etc.
  nixpkgs.config.allowUnfree = true;

  # --- 6. ENVIRONNEMENT GRAPHIQUE (HYPRLAND) ---
  programs.hyprland.enable = true; # Active Hyprland
  
  # Login Manager : Ly
  services.displayManager.ly.enable = true;

  # --- 7. PAQUETS SYSTÈME ---
  environment.systemPackages = with pkgs; [
    # GUI / Core
    warp-terminal
    chromium
    wofi       # Lanceur d'applications (menu)
    waybar     # Barre d'état (souvent nécessaire avec Hyprland)
    dunst      # Notifications
    kitty      # Terminal de secours (conseillé si Warp a un souci au début)

    # CLI Tools (Votre liste)
    btop       # Monitoring
    fastfetch  # Info système
    fd         # Find amélioré
    git
    stow
    neovim
    ripgrep    # Grep amélioré
    zellij     # Multiplexeur
    yazi       # File manager (Probablement ce que vous appeliez "zazi")
    zoxide     # "cd" plus intelligent (bonus souvent utilisé avec ce stack)
    
    # Gestion du son
    pavucontrol
  ];

  # --- 8. FONTS (Polices) ---
  # Crucial pour que Warp, Hyprland et Fastfetch affichent les icônes
  fonts.packages = with pkgs; [
    nerdfonts
    font-awesome
  ];

  # --- 9. SON ---
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Version de l'état (Ne pas toucher)
  system.stateVersion = "24.05"; 
}