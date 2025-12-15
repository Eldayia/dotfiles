# CLAUDE.md

Ce fichier fournit des directives à WARP (warp.dev) et Claude lors du travail avec le code de ce dépôt.

## Vue d'ensemble du projet

Dépôt de dotfiles pour une installation NixOS avec environnement Hyprland (Wayland compositor). Configuration complète pour un poste de développement moderne avec shell Nushell et terminal Warp.

## Structure du dépôt

Le dépôt est organisé comme suit :

- **nixos/** : Configuration système NixOS (modulaire)
  - `configuration.nix` : Point d'entrée (importe tous les modules)
  - `hardware-configuration.nix` : Configuration matérielle générée automatiquement
  - `modules/` : Modules de configuration par thème (boot, network, locale, users, packages, etc.)
  - `services/` : Services système (audio, display-manager)

- **.config/** : Configurations utilisateur
  - `hypr/` : Configuration Hyprland (gestionnaire de fenêtres Wayland)
  - `nvim/` : Configuration Neovim
  - `waybar/` : Configuration Waybar (barre d'état)

- **Scripts de gestion** :
  - `install-prep.sh` : Préparation installation NixOS (clavier, wifi, partitionnement, génération config)
  - `install-update.sh` : Copie la config du dépôt vers `/etc/nixos/` (avec sauvegarde)
  - `sync-nixos.sh` : Copie `/etc/nixos/` vers le dépôt puis commit/push
  - `sync-dotfiles.sh` : Commit/push les modifications des dotfiles
  - `sync-all.sh` : Exécute sync-dotfiles.sh puis sync-nixos.sh

- **Scripts de déploiement VM** :
  - `deploy-vm.sh` : Déploiement automatique complet sur VM (Stow + NixOS rebuild)
  - `fix-stow-conflicts.sh` : Résolution automatique des conflits Stow

- **Scripts de diagnostic Hyprland** :
  - `diagnose-hyprland.sh` : Diagnostic complet (processus, services, apps, logs)
  - `check-status.sh` : Vérification rapide de l'état Hyprland
  - `start-hyprland.sh` : Lancement assisté de Hyprland
  - `collect-logs.sh` : Collecte et envoi automatique des logs vers Hastebin
  - `test-hyprland.sh` : Test automatique des fonctionnalités

- **Documentation** :
  - `README.md` : Documentation principale
  - `CLAUDE.md` : Directives pour IA
  - `STOW.md` : Documentation GNU Stow
  - `DEPLOY-VM.md` : Guide de déploiement sur VM
  - `TROUBLESHOOT.md` : Guide de dépannage Hyprland
  - `.stow-local-ignore` : Fichiers à ignorer lors du déploiement Stow

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

### Workflow automatisé (recommandé)

#### Synchroniser tout (dotfiles + NixOS)
```bash
./sync-all.sh
```
Ce script exécute `sync-dotfiles.sh` puis `sync-nixos.sh`.

#### Synchroniser uniquement les dotfiles
```bash
./sync-dotfiles.sh
```
- Stage tous les changements dans le dépôt
- Affiche les différences avec diff-so-fancy
- Demande un message de commit
- Commit et push sur la branche nixos

#### Synchroniser uniquement la config NixOS
```bash
./sync-nixos.sh
```
- Copie `/etc/nixos/` vers `./nixos` (avec sudo)
- Change le propriétaire et permissions
- Affiche les différences avec diff-so-fancy
- Demande confirmation pour ajouter à git
- Demande un message de commit
- Commit et push

### Workflow manuel

1. Modifier les fichiers dans ce dépôt
2. Pour NixOS : copier vers `/etc/nixos/` avec `./install-update.sh`
3. Pour dotfiles : les modifications sont automatiques (symlinks Stow)
4. Tester :
   - NixOS : `sudo nixos-rebuild test`
   - Dotfiles : Relancer l'application concernée
5. Versionner : `git add . && git commit -m "message" && git push origin nixos`
6. Pour NixOS : `sudo nixos-rebuild switch` pour activer définitivement

## Outils de diagnostic et déploiement

### Déploiement sur VM

Pour déployer rapidement sur une VM NixOS :
```bash
cd ~/dotfiles
./deploy-vm.sh
```

Ce script effectue :
- Sauvegarde des fichiers en conflit
- Déploiement avec Stow
- Copie de la config NixOS vers `/etc/nixos/`
- Rebuild automatique du système

### Résolution de conflits Stow

Si Stow refuse de créer des liens symboliques :
```bash
cd ~/dotfiles
./fix-stow-conflicts.sh
```

### Diagnostic Hyprland

Pour diagnostiquer les problèmes Hyprland :

```bash
# Diagnostic complet (vérifie processus, services, apps, logs)
./diagnose-hyprland.sh

# Vérification rapide de l'état
./check-status.sh

# Lancement assisté de Hyprland
./start-hyprland.sh

# Collecte et envoi des logs pour debug
./collect-logs.sh

# Test des fonctionnalités
./test-hyprland.sh
```

### Configurations spéciales

- `hyprland-minimal.conf` : Configuration Hyprland minimaliste pour tester en cas de problème

## Notes de développement

- Ce dépôt est personnel mais ouvert aux suggestions via issues/PRs
- Les configurations sont optimisées pour une VM (notamment `WLR_NO_HARDWARE_CURSORS=1`)
- Toujours communiquer en français avec l'utilisateur
- Le système utilise les polices Nerd Fonts pour l'affichage des icônes
- Le développement se fait sous Windows, le déploiement sur VM NixOS
- Des outils complets de diagnostic et déploiement sont disponibles
