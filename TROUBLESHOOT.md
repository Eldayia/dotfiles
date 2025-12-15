# Guide de dépannage Hyprland

## Symptômes actuels

- ✓ Wofi se lance (Ctrl+Space)
- ❌ Autres raccourcis ne fonctionnent pas
- ❌ Impossible de lancer des applications depuis Wofi
- ❌ Waybar ne s'affiche pas

## Diagnostic rapide

### 1. Exécutez le script de diagnostic

```bash
cd ~/dotfiles
git pull
./diagnose-hyprland.sh
```

Ce script va vérifier:
- Si Hyprland tourne correctement
- Si les applications sont installées
- Si les services (Waybar, Dunst) tournent
- Les logs d'erreur

### 2. Vérifications manuelles

#### Dans un terminal (depuis Wofi ou existant):

```bash
# Vérifier que les applications existent
which kitty
which warp-terminal
which waybar
which microsoft-edge

# Lancer Waybar manuellement
waybar &

# Tester le lancement d'une app via hyprctl
hyprctl dispatch exec kitty

# Voir les logs Hyprland en temps réel
tail -f /tmp/hypr/$(ls -t /tmp/hypr/ | head -1)/hyprland.log
```

### 3. Problèmes courants et solutions

#### A. Waybar ne démarre pas

**Cause:** Erreur dans la config ou service non lancé

**Solution:**
```bash
# Tuer Waybar s'il tourne
pkill waybar

# Lancer avec logs de debug
waybar -l debug

# Si erreur de config, utiliser config minimale
waybar -c ~/.config/waybar/config -s ~/.config/waybar/style.css
```

#### B. Applications ne se lancent pas

**Cause 1:** Applications pas dans le PATH

```bash
# Vérifier le PATH
echo $PATH

# Essayer avec chemin complet
hyprctl dispatch exec /run/current-system/sw/bin/kitty
```

**Cause 2:** Applications nécessitent des flags Wayland

```bash
# Pour Warp (si problème)
hyprctl dispatch exec "warp-terminal --enable-features=UseOzonePlatform --ozone-platform=wayland"
```

**Cause 3:** Workspace bindings bloquent le lancement

```bash
# Tester sans workspace
hyprctl dispatch exec kitty
# au lieu de
# bind = CTRL, T, exec, [workspace 1 silent] kitty
```

#### C. Raccourcis clavier ne fonctionnent pas

```bash
# Vérifier les bindings actifs
hyprctl binds | grep CTRL

# Recharger la config
hyprctl reload

# Tester un binding manuellement
hyprctl dispatch exec kitty
```

## Configuration minimale de test

Si rien ne fonctionne, utilisez la configuration minimale:

```bash
# Sauvegarder l'ancienne config
cp ~/.config/hypr/hyprland.conf ~/.config/hypr/hyprland.conf.backup

# Utiliser la config minimale
cp ~/dotfiles/hyprland-minimal.conf ~/.config/hypr/hyprland.conf

# Recharger
hyprctl reload
```

La config minimale:
- Désactive les animations
- Utilise Kitty au lieu de Warp (plus simple)
- Pas de workspace bindings
- Décoration minimale

Testez avec `Ctrl+T` pour lancer Kitty.

## Script de test automatique

```bash
cd ~/dotfiles
./test-hyprland.sh
```

Ce script teste:
- Présence des applications
- Lancement de Waybar
- Lancement d'apps via hyprctl
- Keybinds actifs

## Solutions par ordre de complexité

### Solution 1: Relancer les services (Simple)

```bash
# Relancer Waybar
pkill waybar && waybar &

# Relancer Dunst
pkill dunst && dunst &

# Recharger Hyprland
hyprctl reload
```

### Solution 2: Config minimale (Moyen)

```bash
cp ~/dotfiles/hyprland-minimal.conf ~/.config/hypr/hyprland.conf
hyprctl reload
```

### Solution 3: Rebuild NixOS (Avancé)

```bash
# S'assurer que tout est bien installé
sudo nixos-rebuild switch

# Redémarrer la session
# Ctrl+M puis se reconnecter
```

### Solution 4: Vérifier les packages NixOS (Avancé)

```bash
# Vérifier que Hyprland et les paquets sont installés
nix-store -q --references /run/current-system | grep hyprland

# Lister les paquets installés
nix-env -q

# Si manquant, vérifier /etc/nixos/modules/packages.nix
cat /etc/nixos/modules/packages.nix
```

## Logs importants

```bash
# Logs Hyprland
tail -f /tmp/hypr/$(ls -t /tmp/hypr/ | head -1)/hyprland.log

# Logs système
journalctl -f | grep -i hypr

# Logs Waybar
journalctl -f | grep -i waybar
```

## Commandes utiles hyprctl

```bash
# Lister toutes les fenêtres
hyprctl clients

# Lister tous les workspaces
hyprctl workspaces

# Voir la config active
hyprctl getoption general:border_size

# Recharger la config
hyprctl reload

# Exécuter une commande
hyprctl dispatch exec kitty

# Tuer une fenêtre
hyprctl dispatch killactive

# Voir toutes les commandes disponibles
hyprctl --help
```

## Si tout échoue

1. **Vérifier que NixOS a bien rebuild:**
   ```bash
   sudo nixos-rebuild switch
   ```

2. **Redémarrer complètement la VM:**
   ```bash
   sudo reboot
   ```

3. **Essayer un autre WM temporairement:**
   - Installer i3wm pour tester
   - Si i3 fonctionne, le problème est spécifique à Hyprland

4. **Chercher dans les issues GitHub de Hyprland:**
   - Problèmes VM: https://github.com/hyprwm/Hyprland/issues?q=vm
   - Problèmes Wayland: https://github.com/hyprwm/Hyprland/issues?q=wayland

## Informations à collecter pour debug

Si vous devez demander de l'aide, collectez:

```bash
# Version Hyprland
hyprctl version

# Config active
cat ~/.config/hypr/hyprland.conf

# Logs récents
tail -100 /tmp/hypr/$(ls -t /tmp/hypr/ | head -1)/hyprland.log

# Environnement
env | grep -E "WAYLAND|XDG|DISPLAY"

# Packages installés
nix-env -q
```
