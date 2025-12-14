# Guide de Dépannage Hyprland

## Problème : Les applications ne se lancent pas

### Cause probable
Les applications ne sont pas accessibles dans l'environnement Hyprland car NixOS nécessite une configuration spécifique pour que les paquets système soient disponibles.

### Solution

#### 1. Mettre à jour la configuration NixOS
Copie la config depuis le dépôt vers le système :

```bash
cd ~/dotfiles
sudo ./install-update.sh
```

#### 2. Reconstruire le système
```bash
sudo nixos-rebuild switch
```

#### 3. Vérifier que les applications sont installées
```bash
which warp-terminal kitty chromium wofi waybar
```

Tous ces chemins doivent retourner un résultat. Si l'une des commandes échoue, l'application n'est pas installée.

#### 4. Recharger Hyprland
```bash
# Option 1 : Raccourci clavier
SUPER + SHIFT + C

# Option 2 : Redémarrer le display manager
systemctl restart display-manager

# Option 3 : Redémarrer complètement
sudo reboot
```

### Vérification des logs

Si ça ne marche toujours pas, vérifie les logs Hyprland :

```bash
# Lancer Hyprland en debug
Hyprland -i

# Voir les erreurs
cat ~/.cache/hyprland/hyprland.log
```

### Problème spécifique : Waybar ne s'affiche pas

Si Waybar n'apparaît pas, c'est probablement un problème de configuration CSS.

1. Vérifie que la config existe :
```bash
ls -la ~/.config/waybar/
```

2. Teste Waybar directement :
```bash
waybar
```

3. Vérifiez les logs de Waybar :
```bash
journalctl -u waybar
```

### Raccourcis clavier disponibles

Après la correction, les raccourcis suivants doivent fonctionner :

- **Ctrl + T** : Ouvrir Warp Terminal
- **Ctrl + Q** : Ouvrir Kitty Terminal
- **Ctrl + B** : Ouvrir Chromium
- **Ctrl + E** : Ouvrir Warp avec Yazi
- **Ctrl + Space** : Ouvrir Wofi (lanceur)
- **Ctrl + C** : Fermer la fenêtre active
- **Ctrl + M** : Quitter Hyprland
- **Ctrl + V** : Activer/désactiver le mode flottant

### Configuration supplémentaire

Si tu veux que les applications se lancent avec des options par défaut, tu peux créer des scripts shell dans `~/.local/bin/` :

```bash
mkdir -p ~/.local/bin/
```

Puis créer par exemple `~/.local/bin/launch-terminal` :

```bash
#!/usr/bin/env bash
exec warp-terminal
```

Et l'utiliser dans hyprland.conf :
```
bind = $mainMod, T, exec, ~/.local/bin/launch-terminal
```

### Notes pour VM

Si tu utilises une VM, assure-toi que :

1. **3D Acceleration est activée** dans VMware/VirtualBox (améliore grandement les performances)
2. **Au moins 4GB de RAM** est alloué à la VM
3. **Les additions Guest** sont à jour (pour VMware)
4. Les variables d'environnement dans hyprland.conf incluent :
   ```
   env = WLR_NO_HARDWARE_CURSORS,1
   env = NIXOS_OZONE_WL,1
   ```

## Problèmes courants

### 1. "command not found: warp-terminal"
- La pkg n'est pas installée ou la config NixOS n'a pas été appliquée
- Voir section "Mettre à jour la configuration NixOS"

### 2. "Hyprland is not running"
- Les applications ne peuvent se lancer que depuis Hyprland
- Assure-toi d'être connecté au display manager et dans une session Hyprland

### 3. Les raccourcis clavier ne fonctionnent pas
- La configuration hyprland.conf n'a pas été rechargée
- Redémarre Hyprland avec `SUPER + SHIFT + C` (note: cela redémarre Hyprland)
- Ou reconnecte-toi au display manager

### 4. Performance lente
- Désactive les ombres et le blur dans hyprland.conf si nécessaire
- Augmente la RAM et le CPU alloués à la VM
- Active l'accélération matérielle 3D

## Commandes utiles pour déboguer

```bash
# Voir la configuration actuelle chargée par Hyprland
hyprctl getoption -j

# Lister tous les bindings
hyprctl binds

# Recharger la configuration
hyprctl reload

# Voir les informations système
fastfetch

# Vérifier les paquets Nix disponibles
nix-shell -p warp-terminal

# Vérifier Wofi fonctionne
wofi --show drun -i
```
