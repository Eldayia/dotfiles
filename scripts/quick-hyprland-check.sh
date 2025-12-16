#!/usr/bin/env bash

echo "=== DIAGNOSTIC HYPRLAND RAPIDE ==="
echo ""

echo "1. Configuration Hyprland :"
if [ -f ~/.config/hypr/hyprland.conf ]; then
    echo "✓ hyprland.conf existe"
    ls -lah ~/.config/hypr/hyprland.conf
else
    echo "✗ hyprland.conf MANQUANT"
fi

echo ""
echo "2. Processus Hyprland :"
ps aux | grep -i hyprland | grep -v grep

echo ""
echo "3. Variables d'environnement :"
echo "WAYLAND_DISPLAY=$WAYLAND_DISPLAY"
echo "XDG_CURRENT_DESKTOP=$XDG_CURRENT_DESKTOP"
echo "XDG_SESSION_TYPE=$XDG_SESSION_TYPE"

echo ""
echo "4. Logs Hyprland (dernières 20 lignes) :"
if [ -f /tmp/hypr/$(echo $USER)/hyprland.log ]; then
    tail -20 /tmp/hypr/$(echo $USER)/hyprland.log
else
    echo "Pas de log trouvé"
fi

echo ""
echo "5. Driver graphique :"
glxinfo | grep "OpenGL renderer" || echo "glxinfo non disponible"
lsmod | grep vmwgfx

echo ""
echo "6. Contenu dotfiles/.config/hypr/ :"
ls -la ~/dotfiles/.config/hypr/ 2>/dev/null || echo "Dossier non trouvé"

echo ""
echo "=== FIN DIAGNOSTIC ==="
