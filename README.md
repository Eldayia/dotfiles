<p align="center">
  <img src="nixos.jpg" alt="dotfiles Banner">
</p>

<p align="center">
  <a href="https://nixos.org/"><img src="https://img.shields.io/badge/NixOS-blue?logo=nixos&logoColor=white&style=flat-square"></a>
  <a href="https://www.gnu.org/software/stow/"><img src="https://img.shields.io/badge/Stow-portable-green?logo=gnu&style=flat-square"></a>
  <a href="https://github.com/ghostty-org/ghostty"><img src="https://img.shields.io/badge/Ghostty-terminal-7B7B7B?logo=terminal&style=flat-square"></a>
  <a href="https://hyprland.org/"><img src="https://img.shields.io/badge/Hyprland-wayland-6C63FF?logo=wayland&style=flat-square"></a>
  <a href="https://neovim.io/"><img src="https://img.shields.io/badge/Neovim-lazyvim-57A143?logo=neovim&style=flat-square"></a>
  <a href="https://www.nushell.sh/"><img src="https://img.shields.io/badge/Nushell-shell-4E9996?logo=nushell&logoColor=white&style=flat-square"></a>
  <a href="https://starship.rs/"><img src="https://img.shields.io/badge/Starship-fast-7d5fff?logo=starship&style=flat-square"></a>
  <a href="https://catppuccin.com/"><img src="https://img.shields.io/badge/Theme-Catppuccin-F5C2E7?logo=paintpalette&logoColor=white&style=flat-square"></a>
</p>

# dotfiles NixOS by Eldayia

Configuration complète pour NixOS avec environnement Hyprland (Wayland). Cette branche est dédiée exclusivement à NixOS et utilise GNU Stow pour la gestion des dotfiles.

---

> Merci à <b>RikiLaNeko</b> de m’avoir fait découvrir NixOS et pour sa base de config <a href="https://gitlab.com/RikiLaNeko/dotfiles.git">dotfiles</a>

---

## 📦 Stack technique

- **OS** : NixOS 24.05
- **Display Manager** : Ly
- **Window Manager** : Hyprland (Wayland)
- **Shell** : Nushell (défaut système)
- **Terminal** : Warp Terminal (principal), Kitty (secours)
- **Launcher** : Wofi
- **Status Bar** : Waybar
- **Notifications** : Dunst
- **Outils CLI** : btop, fastfetch, fd, git, stow, neovim, ripgrep, zellij, yazi, zoxide

## 📁 Structure du dépôt

```
dotfiles/
├── nixos/                  # Configuration système NixOS
│   ├── configuration.nix   # Configuration principale du système
│   └── hardware-configuration.nix  # Configuration matérielle (auto-générée)
├── .config/                # Configurations utilisateur
│   ├── hypr/               # Hyprland (window manager)
│   ├── nvim/               # Neovim
│   └── waybar/             # Barre d'état
├── CLAUDE.md               # Directives pour IA (WARP + Claude)
├── README.md               # Ce fichier
└── STOW.md                 # Documentation GNU Stow
```

## 🚀 Installation rapide

### 1. Cloner le dépôt

```bash
cd ~
git clone https://github.com/VOTRE_USERNAME/dotfiles.git
cd dotfiles
git checkout nixos
```

### 2. Installer la configuration NixOS

```bash
# Copier la configuration système
sudo cp nixos/configuration.nix /etc/nixos/

# Tester la configuration (sans l'activer au démarrage)
sudo nixos-rebuild test

# Si tout fonctionne, activer définitivement
sudo nixos-rebuild switch
```

### 3. Déployer les dotfiles avec Stow

```bash
# Déployer toutes les configurations
stow -v -t ~/ .

# Ou sélectivement (exemple pour Hyprland uniquement)
stow -v -t ~/ --dir=. --target=~/.config/hypr .config/hypr
```

Pour plus de détails sur l'utilisation de Stow, consultez [STOW.md](STOW.md).

## 🔧 Configuration NixOS

Le fichier `nixos/configuration.nix` configure :

### 1. **Bootloader UEFI**
- Utilise systemd-boot pour le démarrage
- Active la modification des variables EFI

### 2. **Réseau**
- Nom d'hôte : `nixos-hypr`
- NetworkManager activé pour la gestion simple du réseau

### 3. **Localisation**
- Fuseau horaire : Europe/Paris
- Locale : fr_FR.UTF-8
- Clavier : AZERTY français

### 4. **Utilisateur et Shell**
- Nushell défini comme shell par défaut du système
- Utilisateur `eldayia` avec droits sudo (groupe `wheel`)
- Accès NetworkManager pour gestion réseau

### 5. **Logiciels propriétaires**
- `allowUnfree = true` pour autoriser Warp Terminal, Chrome, etc.

### 6. **Environnement graphique**
- **Hyprland** : Gestionnaire de fenêtres Wayland moderne et performant
- **Ly** : Display manager minimaliste en mode texte

### 7. **Paquets installés**

**GUI / Core :**
- Warp Terminal (principal)
- Chromium (navigateur)
- Wofi (lanceur d'applications)
- Waybar (barre d'état)
- Dunst (notifications)
- Kitty (terminal de secours)

**CLI Tools :**
- `btop` : Monitoring système
- `fastfetch` : Information système
- `fd` : Alternative moderne à `find`
- `git` : Gestion de version
- `stow` : Gestion de dotfiles
- `neovim` : Éditeur de texte
- `ripgrep` : Alternative à `grep`
- `zellij` : Multiplexeur de terminal
- `yazi` : Gestionnaire de fichiers TUI
- `zoxide` : Navigation intelligente (`cd` amélioré)

**Audio :**
- `pavucontrol` : Contrôle du volume

### 8. **Polices**
- Nerd Fonts (icônes pour terminal et applications)
- Font Awesome (icônes supplémentaires)

### 9. **Son**
- PipeWire activé avec support ALSA et PulseAudio
- RTKit activé pour la gestion des priorités temps-réel

## 📝 Commandes NixOS essentielles

```bash
# Éditer la configuration
sudo nvim /etc/nixos/configuration.nix

# Reconstruire le système (appliquer les changements)
sudo nixos-rebuild switch

# Tester sans activer au démarrage
sudo nixos-rebuild test

# Nettoyer les anciennes générations
sudo nix-collect-garbage -d

# Lister les générations
sudo nix-env --list-generations --profile /nix/var/nix/profiles/system
```

## 🛠️ Workflow de modification

1. **Modifier** les fichiers dans ce dépôt
2. **Déployer** :
   - Pour NixOS : `sudo cp nixos/configuration.nix /etc/nixos/`
   - Pour dotfiles : `stow -v -t ~/ .` (voir STOW.md)
3. **Tester** :
   - NixOS : `sudo nixos-rebuild test`
   - Dotfiles : Relancer l'application concernée
4. **Versionner** : `git add . && git commit -m "description" && git push`
5. **Activer** (NixOS) : `sudo nixos-rebuild switch`

## 📚 Documentation

- [CLAUDE.md](CLAUDE.md) : Directives pour l'IA WARP et Claude
- [STOW.md](STOW.md) : Guide complet sur GNU Stow
- [NixOS Manual](https://nixos.org/manual/nixos/stable/)
- [Hyprland Wiki](https://wiki.hyprland.org/)

## 💬 Contribuer

Ce dépôt est personnel mais les suggestions sont bienvenues via issues ou pull requests.

