# Configuration NixOS sur WSL2

Guide pour installer et configurer NixOS avec Hyprland sur Windows Subsystem for Linux 2.

## Prérequis

### 1. Activer WSL2 sur Windows

```powershell
# PowerShell en tant qu'administrateur
wsl --install
wsl --set-default-version 2
```

### 2. Installer NixOS sur WSL2

Utiliser [NixOS-WSL](https://github.com/nix-community/NixOS-WSL) :

```powershell
# Télécharger la dernière release de NixOS-WSL
# https://github.com/nix-community/NixOS-WSL/releases

# Importer dans WSL2
wsl --import NixOS C:\WSL\NixOS nixos-wsl.tar.gz --version 2

# Lancer NixOS
wsl -d NixOS
```

## Installation de la configuration

### 1. Cloner le dépôt

```bash
# Depuis WSL2 NixOS
cd ~
git clone -b nixos https://github.com/VOTRE_USERNAME/dotfiles.git
cd dotfiles
```

### 2. Copier la configuration WSL2

```bash
# Utiliser la configuration spécifique WSL2
sudo cp nixos/configuration-wsl.nix /etc/nixos/configuration.nix

# Copier les modules et services
sudo cp -r nixos/modules /etc/nixos/
sudo cp -r nixos/services /etc/nixos/
```

### 3. Adapter la configuration

Modifier `/etc/nixos/modules/wsl.nix` si nécessaire :

```bash
sudo nvim /etc/nixos/modules/wsl.nix
```

Vérifier l'utilisateur par défaut (ligne `defaultUser`).

### 4. Build et activer

```bash
# Tester la configuration
sudo nixos-rebuild test

# Activer définitivement
sudo nixos-rebuild switch
```

### 5. Déployer les dotfiles

```bash
cd ~/dotfiles

# Déployer avec Stow
stow -v -t ~ .config
```

## Lancer Hyprland sur WSL2

### Méthode 1 : Depuis Windows Terminal

WSLg permet d'exécuter des applications graphiques Linux :

```bash
# Lancer Hyprland
Hyprland
```

### Méthode 2 : Créer un raccourci Windows

Créer un fichier `.bat` sur Windows :

```batch
@echo off
wsl -d NixOS -- bash -c "Hyprland"
```

## Configuration WSLg

### Variables d'environnement

WSLg configure automatiquement :
- `DISPLAY=:0` pour X11
- `WAYLAND_DISPLAY=wayland-0` pour Wayland
- XDG_RUNTIME_DIR pour les sockets

### Résolution d'écran

Pour ajuster la résolution dans Hyprland, modifier `.config/hypr/hyprland.conf` :

```conf
# Exemple pour un écran 1920x1080
monitor=,1920x1080,auto,1
```

## Troubleshooting

### Hyprland ne démarre pas

1. Vérifier les variables d'environnement :
```bash
echo $DISPLAY
echo $WAYLAND_DISPLAY
echo $XDG_RUNTIME_DIR
```

2. Tester avec un terminal simple :
```bash
weston-terminal  # ou
kitty
```

3. Vérifier les logs :
```bash
journalctl -xe
```

### Performances graphiques

WSLg utilise le GPU Windows via WSLg. Pour de meilleures performances :

1. Installer les derniers pilotes GPU Windows
2. Activer l'accélération matérielle dans Windows
3. Configurer `WLR_NO_HARDWARE_CURSORS=1` (déjà dans wsl.nix)

### Accès aux fichiers Windows

Les lecteurs Windows sont montés dans `/mnt` :
- `C:\` → `/mnt/c/`
- `D:\` → `/mnt/d/`

## Différences avec la configuration VM

### Modules désactivés
- `vmware.nix` : Non utilisé sur WSL2
- `boot.nix` : Boot géré par Windows
- `display-manager.nix` : Pas de display manager (WSLg)

### Modules spécifiques WSL2
- `wsl.nix` : Configuration WSL2 (réseau, montages, systemd)

### Services
- X11/Wayland géré par WSLg (pas de serveur X séparé)
- Systemd natif activé pour les services

## Ressources

- [NixOS-WSL GitHub](https://github.com/nix-community/NixOS-WSL)
- [WSLg Documentation](https://github.com/microsoft/wslg)
- [Hyprland Wiki](https://wiki.hyprland.org/)
