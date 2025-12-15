# Guide de déploiement sur VM NixOS

## Situation actuelle

Vous développez vos dotfiles depuis **Windows**, mais ils doivent être déployés sur votre **VM NixOS** pour fonctionner avec Hyprland.

## Méthode 1: Script automatique (Recommandé)

### Depuis la VM NixOS:

```bash
# 1. Cloner le dépôt dans la VM (si pas déjà fait)
cd ~
git clone https://github.com/Eldayia/dotfiles.git
cd dotfiles
git checkout nixos

# 2. Exécuter le script de déploiement
./deploy-vm.sh
```

Le script va:
- Déployer les dotfiles avec Stow
- Copier la config NixOS vers /etc/nixos/
- Rebuilder le système
- Afficher les instructions suivantes

## Méthode 2: Déploiement manuel

### Depuis la VM NixOS:

```bash
cd ~/dotfiles

# 1. Déployer les dotfiles avec Stow
stow -v -t ~/ .

# 2. Vérifier que les configs sont bien déployées
ls -la ~/.config/hypr/
ls -la ~/.config/waybar/

# 3. Mettre à jour NixOS
sudo cp -r nixos/* /etc/nixos/
sudo nixos-rebuild switch

# 4. Redémarrer Hyprland
# Se déconnecter et se reconnecter
```

## Méthode 3: Partage de fichiers Windows → VM

Si votre dépôt dotfiles est partagé entre Windows et la VM via VMware Shared Folders:

### Dans la VM:

```bash
# Supposons que le partage est monté dans /mnt/hgfs/dotfiles
cd /mnt/hgfs/dotfiles

# Déployer
stow -v -t ~/ .
sudo cp -r nixos/* /etc/nixos/
sudo nixos-rebuild switch
```

## Diagnostiquer les problèmes Hyprland

### Vérifier les logs Hyprland:

```bash
# Voir les logs en temps réel
journalctl -f | grep hypr

# Voir les erreurs Hyprland
cat /tmp/hypr/$(ls -t /tmp/hypr/ | head -1)/hyprland.log

# Tester la config
hyprctl reload
```

### Problèmes courants:

**1. Waybar ne s'affiche pas:**
```bash
# Vérifier si Waybar tourne
pgrep waybar

# Lancer manuellement
waybar &

# Voir les erreurs
waybar -l debug
```

**2. Raccourcis ne fonctionnent pas:**
```bash
# Vérifier la config
cat ~/.config/hypr/hyprland.conf

# Tester un raccourci manuellement
hyprctl dispatch exec wofi
```

**3. Freeze après ouverture de Wofi:**
```bash
# Vérifier les logs
cat ~/.cache/wofi.log

# Tester avec configuration minimale
wofi --show drun --no-actions
```

## Workflow de développement recommandé

### Sur Windows (développement):
```bash
cd C:/Users/jouan/Dev/dotfiles
# Éditer les fichiers
git add .
git commit -m "Update config"
git push
```

### Dans la VM (déploiement):
```bash
cd ~/dotfiles
git pull
./deploy-vm.sh
```

## Raccourcis Hyprland configurés

- `Ctrl+Space` - Wofi (lanceur)
- `Ctrl+T` - Warp Terminal
- `Ctrl+Q` - Kitty Terminal
- `Ctrl+B` - Microsoft Edge
- `Ctrl+E` - Yazi (file manager)
- `Ctrl+C` - Fermer fenêtre active
- `Ctrl+M` - Quitter Hyprland
- `Ctrl+V` - Activer/désactiver mode flottant
- `Ctrl+1,2,3,4,5` - Changer de workspace
- `Ctrl+Shift+1,2,3,4,5` - Déplacer fenêtre vers workspace

## En cas de problème persistant

```bash
# 1. Vérifier que tous les paquets sont installés
nix-store -q --references /run/current-system | grep -i hypr

# 2. Vérifier les variables d'environnement
echo $XDG_CURRENT_DESKTOP
echo $WAYLAND_DISPLAY

# 3. Redémarrer complètement
sudo reboot

# 4. Vérifier les logs système
journalctl -b | grep -i error
```
