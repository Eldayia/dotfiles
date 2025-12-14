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
├── nixos/                        # Configuration système NixOS
│   ├── configuration.nix         # Point d'entrée (importe tous les modules)
│   ├── hardware-configuration.nix # Configuration matérielle (auto-générée)
│   ├── modules/                  # Modules de configuration par thème
│   │   ├── boot.nix              # Bootloader UEFI
│   │   ├── network.nix           # Réseau et hostname
│   │   ├── locale.nix            # Localisation et clavier
│   │   ├── users.nix             # Utilisateurs et shell
│   │   ├── fonts.nix             # Polices système
│   │   ├── hyprland.nix          # Configuration Hyprland
│   │   ├── packages.nix          # Paquets système de base
│   │   ├── archives.nix          # Outils de compression
│   │   ├── communication.nix     # Discord, Telegram, etc.
│   │   ├── cybersecurity.nix     # Outils de sécurité
│   │   ├── development.nix       # Outils de développement
│   │   ├── multimedia.nix        # Lecteurs audio/vidéo
│   │   ├── network-tools.nix     # Wireshark, nmap, etc.
│   │   ├── terminal-utils.nix    # Outils CLI
│   │   └── web.nix               # Navigateurs
│   └── services/                 # Services système
│       ├── audio.nix             # PipeWire et son
│       └── display-manager.nix   # Ly display manager
├── .config/                      # Configurations utilisateur
│   ├── hypr/                     # Hyprland (window manager)
│   ├── nvim/                     # Neovim
│   └── waybar/                   # Barre d'état
├── install-prep.sh               # Script de préparation installation initiale
├── install-update.sh             # Script de mise à jour de la config NixOS
├── sync-all.sh                   # Synchronise dotfiles + NixOS vers Git
├── sync-dotfiles.sh              # Synchronise uniquement les dotfiles vers Git
├── sync-nixos.sh                 # Copie /etc/nixos vers le dépôt et synchronise
├── .stow-local-ignore            # Fichiers à ignorer lors du déploiement Stow
├── CLAUDE.md                     # Directives pour IA (WARP + Claude)
├── README.md                     # Ce fichier
└── STOW.md                       # Documentation GNU Stow
```

## 🚀 Installation complète

### 1. Préparation de l'environnement NixOS

Lors de l'installation de NixOS, après le partitionnement et avant la première configuration :

```bash
# Monter les partitions (exemple avec UEFI)
mount /dev/sdaX /mnt
mkdir -p /mnt/boot
mount /dev/sdaY /mnt/boot

# Générer la configuration de base
nixos-generate-config --root /mnt
```

### 2. Cloner le dépôt (branche nixos)

**Important :** Ce dépôt utilise la branche `nixos` pour la configuration NixOS.

```bash
# Depuis l'environnement d'installation NixOS
cd /mnt/home

# Cloner directement la branche nixos
git clone -b nixos https://github.com/VOTRE_USERNAME/dotfiles.git
cd dotfiles
```

### 3. Préparer l'installation avec le script

Le script `install-prep.sh` automatise la copie de la configuration vers `/mnt/etc/nixos/` :

```bash
# Rendre le script exécutable
chmod +x install-prep.sh

# Exécuter le script (copie les modules et configuration.nix)
sudo ./install-prep.sh
```

### 4. Adapter la configuration matérielle

**IMPORTANT :** Préservez votre configuration matérielle générée :

```bash
# Le script install-prep.sh ne touche PAS à hardware-configuration.nix
# Votre hardware-configuration.nix généré reste intact dans /mnt/etc/nixos/

# Vérifier que les deux fichiers sont présents
ls -la /mnt/etc/nixos/
# Vous devriez voir :
# - configuration.nix (copié depuis le dépôt)
# - hardware-configuration.nix (généré par nixos-generate-config)
# - modules/ (copié depuis le dépôt)
# - services/ (copié depuis le dépôt)
```

### 5. Personnaliser la configuration

Avant l'installation, modifiez les paramètres selon vos besoins :

```bash
# Éditer le nom d'hôte
sudo nvim /mnt/etc/nixos/modules/network.nix

# Éditer le nom d'utilisateur et le shell
sudo nvim /mnt/etc/nixos/modules/users.nix

# Ajuster le fuseau horaire si nécessaire
sudo nvim /mnt/etc/nixos/modules/locale.nix
```

### 6. Installer NixOS

```bash
# Installation du système avec la configuration
sudo nixos-install

# Définir le mot de passe root
# (le script vous demandera de le faire)

# Redémarrer
reboot
```

### 7. Post-installation : Déployer les dotfiles avec Stow

Après le redémarrage et la connexion, déployez les configurations utilisateur :

```bash
# Se connecter avec votre utilisateur
# Aller dans le dépôt dotfiles
cd ~/dotfiles

# Méthode 1 : Tout déployer (recommandé)
# Le fichier .stow-local-ignore exclut automatiquement nixos/, README.md, etc.
stow -v -t ~ .

# Méthode 2 : Déployer uniquement .config/
stow -v -t ~ .config

# Méthode 3 : Sélectif par application
stow -v -t ~ .config/hypr
stow -v -t ~ .config/waybar
stow -v -t ~ .config/nvim

# Vérifier les liens symboliques créés
ls -la ~/.config/
```

**Note :**
- Stow crée des liens symboliques depuis `~/dotfiles/.config/*` vers `~/.config/*`
- Le fichier `.stow-local-ignore` gère automatiquement l'exclusion des fichiers système, documentation et `nixos/`
- La configuration NixOS (`nixos/`) n'est **pas** gérée par Stow (elle va dans `/etc/nixos/`)

Pour plus de détails sur l'utilisation de Stow, consultez [STOW.md](STOW.md).

### 8. Appliquer les configurations

```bash
# Relancer Hyprland (depuis le display manager ou)
# Appuyez sur SUPER+SHIFT+Q puis reconnectez-vous

# Ou redémarrer le système pour tout charger proprement
sudo reboot
```

## 🔧 Architecture de la configuration NixOS

La configuration est désormais **modulaire** pour faciliter la maintenance et la personnalisation.

### Structure modulaire

Le fichier `nixos/configuration.nix` est le **point d'entrée** qui importe tous les modules thématiques :

#### **Modules système de base**
- `boot.nix` : Bootloader UEFI (systemd-boot)
- `network.nix` : Hostname et NetworkManager
- `locale.nix` : Fuseau horaire (Europe/Paris), locale (fr_FR.UTF-8), clavier AZERTY
- `users.nix` : Utilisateur principal, shell (Nushell), groupes (wheel, networkmanager)
- `fonts.nix` : Nerd Fonts et Font Awesome

#### **Environnement graphique**
- `hyprland.nix` : Configuration Hyprland (Wayland compositor)
- `packages.nix` : Paquets système essentiels (Wofi, Waybar, Dunst, etc.)

#### **Applications par catégorie**
- `archives.nix` : Outils de compression (zip, unzip, tar, etc.)
- `communication.nix` : Discord, Telegram, Signal
- `cybersecurity.nix` : Wireshark, nmap, metasploit, hashcat, etc.
- `development.nix` : VS Code, Docker, Git, Python, NodeJS, etc.
- `multimedia.nix` : VLC, MPV, ffmpeg, OBS
- `network-tools.nix` : tcpdump, iperf, netcat, etc.
- `terminal-utils.nix` : btop, fastfetch, fd, ripgrep, zellij, yazi, zoxide
- `web.nix` : Chromium, Firefox, Warp Terminal

#### **Services système**
- `audio.nix` : PipeWire (ALSA + PulseAudio + RTKit)
- `display-manager.nix` : Ly (display manager minimaliste)

### Avantages de cette architecture

✅ **Modularité** : Chaque aspect du système est dans un fichier dédié
✅ **Clarté** : Facile de trouver où modifier une configuration
✅ **Maintenabilité** : Modifications isolées sans toucher au reste
✅ **Réutilisabilité** : Modules réutilisables entre différentes machines
✅ **Versionning** : Historique Git plus clair avec des fichiers séparés

## 🔄 Scripts de synchronisation

Pour faciliter la gestion des dotfiles et de la configuration NixOS, plusieurs scripts sont disponibles :

### sync-all.sh - Tout synchroniser (recommandé)

Synchronise les dotfiles ET la configuration NixOS en une seule commande :

```bash
cd ~/dotfiles
./sync-all.sh
```

**Ce script exécute :**
1. `sync-dotfiles.sh` (synchronise les modifications dans le dépôt)
2. `sync-nixos.sh` (copie `/etc/nixos/` vers le dépôt et synchronise)

### sync-dotfiles.sh - Dotfiles uniquement

Pour versionner les modifications des dotfiles (`.config/`, scripts, documentation) :

```bash
cd ~/dotfiles
./sync-dotfiles.sh
```

**Fonctionnalités :**
- Stage automatiquement tous les changements
- Affiche les différences avec `diff-so-fancy`
- Demande un message de commit
- Commit et push sur la branche `nixos`
- Ne fait rien si aucun changement détecté

### sync-nixos.sh - Configuration NixOS uniquement

Pour récupérer la configuration NixOS depuis `/etc/nixos/` et la versionner :

```bash
cd ~/dotfiles
./sync-nixos.sh
```

**Fonctionnalités :**
- Copie `/etc/nixos/` vers `./nixos` (avec sudo)
- Ajuste les permissions (propriétaire = utilisateur courant)
- Affiche les différences avec `diff-so-fancy`
- Demande confirmation avant d'ajouter à git
- Demande un message de commit
- Commit et push sur la branche courante

**Note :** Ce script est utile si vous avez modifié directement les fichiers dans `/etc/nixos/` et voulez les sauvegarder dans le dépôt.

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

### ⚡ Workflow rapide (recommandé)

Pour versionner rapidement toutes vos modifications :

```bash
cd ~/dotfiles
./sync-all.sh
```

Ou de manière sélective :
- Dotfiles uniquement : `./sync-dotfiles.sh`
- Config NixOS uniquement : `./sync-nixos.sh`

Ces scripts gèrent automatiquement git add, commit et push avec un affichage des différences.

---

### 📋 Workflow détaillé

#### Pour les dotfiles utilisateur (.config/*)

1. **Modifier** les fichiers dans `~/dotfiles/.config/`
2. Les modifications sont **automatiquement** visibles (grâce aux symlinks créés par Stow)
3. **Tester** : Relancer l'application concernée (ou recharger la config)
   - Hyprland : `SUPER+SHIFT+C` (reload config)
   - Waybar : `pkill waybar && waybar &`
4. **Versionner** :
   ```bash
   cd ~/dotfiles
   ./sync-dotfiles.sh
   # Ou manuellement :
   git add .
   git commit -m "description"
   git push origin nixos
   ```

#### Pour la configuration NixOS (nixos/*)

**Méthode 1 : Modifier depuis le dépôt (recommandé)**

1. **Modifier** les fichiers dans `~/dotfiles/nixos/`
2. **Copier** vers `/etc/nixos/` :
   ```bash
   cd ~/dotfiles
   sudo ./install-update.sh
   ```
3. **Tester** : `sudo nixos-rebuild test`
4. **Activer** : `sudo nixos-rebuild switch`
5. **Versionner** (si OK) :
   ```bash
   ./sync-dotfiles.sh
   ```

**Méthode 2 : Modifier directement dans /etc/nixos/**

1. **Modifier** les fichiers dans `/etc/nixos/`
2. **Tester** : `sudo nixos-rebuild test`
3. **Activer** : `sudo nixos-rebuild switch`
4. **Synchroniser vers le dépôt** :
   ```bash
   cd ~/dotfiles
   ./sync-nixos.sh
   ```
   Le script copie automatiquement `/etc/nixos/` vers `./nixos` et versionne les changements.

## 📚 Documentation

- [CLAUDE.md](CLAUDE.md) : Directives pour l'IA WARP et Claude
- [STOW.md](STOW.md) : Guide complet sur GNU Stow
- [NixOS Manual](https://nixos.org/manual/nixos/stable/)
- [Hyprland Wiki](https://wiki.hyprland.org/)

## 💬 Contribuer

Ce dépôt est personnel mais les suggestions sont bienvenues via issues ou pull requests.

