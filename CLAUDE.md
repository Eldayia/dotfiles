# CLAUDE.md

Ce fichier fournit des directives à WARP (warp.dev) et Claude lors du travail avec le code de ce dépôt.

## Vue d'ensemble du projet

Dépôt de dotfiles pour une installation NixOS avec environnement Hyprland (Wayland compositor). Configuration complète pour un poste de développement moderne avec shell Nushell et terminal Warp.

## Structure du dépôt

Le dépôt est organisé comme suit :

- **nixos/** : Configuration système NixOS
  - `configuration.nix` : Configuration principale du système (bootloader, réseau, utilisateurs, paquets)
  - `hardware-configuration.nix` : Configuration matérielle générée automatiquement

- **.config/hypr/** : Configuration Hyprland (gestionnaire de fenêtres Wayland)
  - `hyprland.conf` : Raccourcis clavier, apparence, animations, workspaces

- **Futurs ajouts prévus** :
  - Configurations Waybar, Dunst, Wofi
  - Dotfiles Nushell
  - Configurations Neovim, Yazi, Zellij

## Stack technique

- **OS** : NixOS 24.05
- **Display Manager** : Ly
- **Window Manager** : Hyprland (Wayland)
- **Shell** : Nushell (par défaut système)
- **Terminal** : Warp Terminal (principal), Kitty (secours)
- **Launcher** : Wofi
- **Status Bar** : Waybar
- **Notifications** : Dunst
- **Outils CLI** : btop, fastfetch, fd, git, stow, neovim, ripgrep, zellij, yazi, zoxide

## Commandes NixOS

### Gestion de la configuration

```bash
# Éditer la configuration système
sudo nvim /etc/nixos/configuration.nix

# Reconstruire le système (appliquer les changements)
sudo nixos-rebuild switch

# Tester la configuration sans l'activer au démarrage
sudo nixos-rebuild test

# Collecter le garbage (nettoyer les anciennes générations)
sudo nix-collect-garbage -d
```

### Commandes Git

```bash
# Ajouter tous les fichiers
git add .

# Commit avec message
git commit -m "message"

# Pousser sur la branche courante
git push origin nixos

# Vérifier l'état
git status
```

## Conventions

### Fichiers NixOS
- Utiliser la syntaxe Nix pour `configuration.nix`
- Commenter les sections principales avec `# --- TITRE ---`
- Grouper les paquets par catégorie (GUI, CLI, etc.)
- Toujours tester avec `nixos-rebuild test` avant `switch`

### Fichiers Hyprland
- Utiliser la syntaxe moderne (v0.40+) pour les blocs `decoration.shadow` et `decoration.blur`
- Documenter les raccourcis clavier avec commentaires clairs
- Respecter la structure : Variables d'env → Apparence → Raccourcis

### Dotfiles généraux
- Éviter les chemins absolus spécifiques à une machine
- Utiliser des chemins relatifs ou des variables d'environnement
- Documenter les dépendances nécessaires

## Workflow de modification

1. Modifier les fichiers dans ce dépôt
2. Copier vers `/etc/nixos/` (pour configuration.nix) ou `~/.config/` (pour dotfiles)
3. Tester avec `nixos-rebuild test` (pour NixOS) ou relancer l'application
4. Si OK, commit et push sur le dépôt
5. Pour NixOS : `sudo nixos-rebuild switch` pour activer définitivement

## Notes de développement

- Ce dépôt est personnel mais ouvert aux suggestions via issues/PRs
- Les configurations sont optimisées pour une VM (notamment `WLR_NO_HARDWARE_CURSORS=1`)
- Toujours communiquer en français avec l'utilisateur
- Le système utilise les polices Nerd Fonts pour l'affichage des icônes
