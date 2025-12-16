# CLAUDE.md

Ce fichier fournit des directives à WARP (warp.dev) et Claude lors du travail avec le code de ce dépôt.

## Vue d'ensemble du projet

Dépôt de dotfiles pour une installation NixOS avec environnement Hyprland (Wayland). Configuration complète pour un poste de développement moderne avec shell Nushell et terminal Warp. Compatible WSL2 et VM (Hyper-V avec GPU-PV). Support X11 + i3 disponible en option.

## Structure du dépôt

Le dépôt est organisé comme suit :

- **nixos/** : Configuration système NixOS (modulaire)
  - `configuration.nix` : Point d'entrée standard (VM/bare metal)
  - `configuration-wsl.nix` : Point d'entrée pour WSL2
  - `hardware-configuration.nix` : Configuration matérielle générée automatiquement
  - `modules/` : Modules de configuration par thème
    - Système de base : boot, network, locale, users, fonts, graphics, session
    - Plateforme : hyperv.nix (ACTIF), virtualbox.nix (optionnel), vmware.nix (optionnel), wsl.nix (WSL2 uniquement)
    - Environnement graphique : wayland.nix (ACTIF), hyprland.nix (ACTIF), x11.nix (optionnel), interface.nix, packages.nix
    - Applications : archives, communication, cybersecurity, development, multimedia, network-tools, terminal-utils, web, screenshot, lockscreen
  - `services/` : Services système (audio, display-manager, ssh)

- **.config/** : Configurations utilisateur
  - `hypr/` : Configuration Hyprland (gestionnaire de fenêtres Wayland) - **ACTIF**
    - `hyprland.conf` : Configuration principale
    - `hyprland-wrapper.sh` : Wrapper de lancement (variables d'environnement)
    - `debug-env.sh` : Script de diagnostic des variables d'environnement
    - `check-graphics.sh` : Script de diagnostic graphique complet
  - `i3/` : Configuration i3 (window manager X11) - OPTIONNEL
    - `config` : Configuration principale i3
    - `i3status.conf` : Configuration barre de statut
    - `debug-env.sh` : Script de diagnostic X11
    - `check-graphics.sh` : Script de diagnostic graphique X11
  - `nvim/` : Configuration Neovim
  - `waybar/` : Configuration Waybar (barre d'état Wayland)
  - `kitty/` : Configuration Kitty terminal

- **scripts/** : Scripts d'installation, déploiement et synchronisation
  - `install-prep.sh` : Préparation installation NixOS (clavier, wifi, partitionnement)
  - `install-update.sh` : Copie la config du dépôt vers `/etc/nixos/` (avec sauvegarde)
  - `deploy-vm.sh` : Déploiement automatique complet sur VM (Stow + NixOS rebuild)
  - `fix-stow-conflicts.sh` : Résolution automatique des conflits Stow
  - `sync-nixos.sh` : Copie `/etc/nixos/` vers le dépôt puis commit/push
  - `sync-dotfiles.sh` : Commit/push les modifications des dotfiles
  - `sync-all.sh` : Exécute sync-dotfiles.sh puis sync-nixos.sh

- **debug/** : Scripts et documentation de diagnostic
  - `check-vmware-3d.sh` : Vérification accélération 3D VMware
  - `diagnose-hyprland.sh` : Diagnostic complet Hyprland (processus, services, apps, logs)
  - `check-status.sh` : Vérification rapide de l'état Hyprland
  - `start-hyprland.sh` : Lancement assisté de Hyprland
  - `collect-logs.sh` : Collecte et envoi automatique des logs vers Hastebin
  - `test-hyprland.sh` : Test automatique des fonctionnalités
  - `HYPRLAND_DEBUG.md` : Documentation de débogage Hyprland

- **Documentation** :
  - `README.md` : Documentation principale
  - `CLAUDE.md` : Directives pour IA
  - `STOW.md` : Documentation GNU Stow
  - `DEPLOY-VM.md` : Guide de déploiement sur VM
  - `WSL2-SETUP.md` : Guide d'installation sur WSL2
  - `TROUBLESHOOT.md` : Guide de dépannage Hyprland
  - `.stow-local-ignore` : Fichiers à ignorer lors du déploiement Stow

## Stack technique

- **OS** : NixOS 24.05
- **Plateforme** : Hyper-V avec GPU-PV (principal), WSL2/VirtualBox/VMware (supportés)
- **Display Manager** : Ly
- **Window Manager** : Hyprland (Wayland) - **ACTIF** | i3 (X11) disponible en option
- **Shell** : Nushell (par défaut système)
- **Terminal** : Warp Terminal (principal), Kitty (secondaire), Ghostty (alternatif)
- **Launcher** : wofi (Hyprland), rofi (compatible), dmenu (i3)
- **Status Bar** : waybar (Hyprland), i3status/i3blocks (i3)
- **Notifications** : Dunst
- **Graphics** : Mesa avec driver i915/modesetting + GPU Intel (Hyper-V GPU-PV) ou WSLg (WSL2)
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

### Fichiers i3
- Utiliser la syntaxe i3 standard pour la configuration
- Documenter les raccourcis clavier avec commentaires clairs
- Respecter la structure : Variables → Apparence → Raccourcis → Workspaces
- Les raccourcis utilisent Control (Ctrl) comme modificateur principal pour cohérence avec l'ancienne config Hyprland

### Fichiers Hyprland (si activé)
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
./scripts/sync-all.sh
```
Ce script exécute `sync-dotfiles.sh` puis `sync-nixos.sh`.

#### Synchroniser uniquement les dotfiles
```bash
./scripts/sync-dotfiles.sh
```
- Stage tous les changements dans le dépôt
- Affiche les différences avec diff-so-fancy
- Demande un message de commit
- Commit et push sur la branche nixos

#### Synchroniser uniquement la config NixOS
```bash
./scripts/sync-nixos.sh
```
- Copie `/etc/nixos/` vers `./nixos` (avec sudo)
- Change le propriétaire et permissions
- Affiche les différences avec diff-so-fancy
- Demande confirmation pour ajouter à git
- Demande un message de commit
- Commit et push

### Workflow manuel

1. Modifier les fichiers dans ce dépôt
2. Pour NixOS : copier vers `/etc/nixos/` avec `./scripts/install-update.sh`
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
./scripts/deploy-vm.sh
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
./scripts/fix-stow-conflicts.sh
```

### Diagnostic VMware et graphique

#### Diagnostic accélération 3D VMware
```bash
./debug/check-vmware-3d.sh
```
Vérifie si l'accélération 3D VMware est activée et affiche la mémoire vidéo disponible.

#### Diagnostic i3 et X11
Raccourcis clavier disponibles dans i3 :
- **Ctrl+D** : Lance `.config/i3/debug-env.sh` (variables d'environnement)
- **Ctrl+Shift+D** : Lance `.config/i3/check-graphics.sh` (diagnostic graphique complet X11)

#### Diagnostic Hyprland complet (si Wayland activé)
```bash
# Diagnostic complet (processus, services, apps, logs)
./debug/diagnose-hyprland.sh

# Vérification rapide de l'état
./debug/check-status.sh

# Lancement assisté de Hyprland
./debug/start-hyprland.sh

# Collecte et envoi des logs vers Hastebin
./debug/collect-logs.sh

# Test des fonctionnalités
./debug/test-hyprland.sh
```

## Notes de développement

- Ce dépôt est personnel mais ouvert aux suggestions via issues/PRs
- Configuration principale : Hyprland (Wayland) pour environnement moderne
- Support i3 (X11) disponible en option (module x11.nix commenté)
- Plateforme principale : Hyper-V avec GPU-PV (accélération 3D matérielle Intel)
- Plateformes supportées : WSL2 (configuration-wsl.nix), VirtualBox (virtualbox.nix), VMware (vmware.nix)
- Toujours communiquer en français avec l'utilisateur
- Le système utilise les polices Nerd Fonts pour l'affichage des icônes
- Le développement se fait sous Windows, le déploiement sur VM NixOS (Hyper-V)
- Des outils complets de diagnostic et déploiement sont disponibles

## Architecture modulaire

La configuration NixOS est organisée en modules thématiques :

### Modules d'environnement graphique
- **x11.nix** (ACTIF) : Serveur X11, i3 window manager, dmenu, variables d'environnement X11
- **interface.nix** : Applications d'interface communes (wofi, waybar, rofi, i3status, i3blocks, nautilus, polkit, GTK libs)
- **packages.nix** : Terminaux (warp-terminal, kitty), notifications (dunst), clipboard (xclip)
- **wayland.nix** (optionnel) : Protocoles et bibliothèques Wayland pures, XDG portals
- **hyprland.nix** (optionnel) : Configuration Hyprland compositor avec XWayland

### Organisation des paquets
- **Terminaux** : warp-terminal et kitty dans packages.nix, ghostty dans terminal-utils.nix
- **Interface graphique** : Applications partagées dans interface.nix (lanceurs, barres d'état, gestionnaire de fichiers)
- **Outils spécifiques** : X11 utils dans x11.nix, Wayland utils dans wayland.nix
- **Pas de doublons** : Chaque paquet est défini une seule fois dans le module le plus approprié
