#!/usr/bin/env bash
# Vérification simple de l'état

echo "=== VÉRIFICATION ÉTAT ACTUEL ==="
echo ""

echo "1. Êtes-vous en mode graphique?"
echo "   WAYLAND_DISPLAY: ${WAYLAND_DISPLAY:-NON}"
echo "   DISPLAY: ${DISPLAY:-NON}"
echo ""

echo "2. Hyprland est-il installé?"
if command -v Hyprland &> /dev/null; then
    echo "   ✓ OUI: $(which Hyprland)"
else
    echo "   ✗ NON - Hyprland n'est pas installé!"
    echo ""
    echo "   Il faut faire: sudo nixos-rebuild switch"
    exit 1
fi
echo ""

echo "3. Hyprland tourne-t-il actuellement?"
if pgrep -x Hyprland > /dev/null; then
    echo "   ✓ OUI (PID: $(pgrep -x Hyprland))"
else
    echo "   ✗ NON - Hyprland ne tourne pas"
fi
echo ""

echo "4. Y a-t-il des logs Hyprland?"
if [ -d /tmp/hypr ]; then
    echo "   Répertoire /tmp/hypr existe"
    echo "   Contenu:"
    ls -la /tmp/hypr/
    echo ""

    LATEST_LOG=$(ls -t /tmp/hypr/*/hyprland.log 2>/dev/null | head -1)
    if [ -f "$LATEST_LOG" ]; then
        echo "   Log trouvé: $LATEST_LOG"
        echo "   Taille: $(wc -l < "$LATEST_LOG") lignes"
    else
        echo "   ✗ Aucun fichier hyprland.log trouvé"
    fi
else
    echo "   ✗ Répertoire /tmp/hypr n'existe pas"
    echo "   → Hyprland n'a jamais été lancé"
fi
echo ""

echo "5. Display manager (Ly) est-il actif?"
if systemctl is-active display-manager &> /dev/null; then
    echo "   ✓ OUI"
    systemctl status display-manager --no-pager | head -5
else
    echo "   ✗ NON"
fi
echo ""

echo "=== DIAGNOSTIC ==="
echo ""

if [ -z "$WAYLAND_DISPLAY" ] && ! pgrep -x Hyprland > /dev/null; then
    echo "❌ Hyprland N'EST PAS LANCÉ"
    echo ""
    echo "Pour lancer Hyprland, tapez:"
    echo "   Hyprland"
    echo ""
    echo "Que se passe-t-il quand vous tapez cette commande?"
    echo "Répondez avec ce que vous voyez exactement."
else
    echo "✓ Hyprland semble tourner"
fi
