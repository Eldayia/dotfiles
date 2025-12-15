#!/usr/bin/env bash
# Script de test rapide pour Hyprland

echo "=== TEST HYPRLAND ==="
echo ""

# 1. Tester si les commandes de base fonctionnent
echo "1. Test des commandes de base:"
echo ""

echo -n "  kitty: "
if command -v kitty &> /dev/null; then
    echo "✓"
else
    echo "❌ NON TROUVÉ"
fi

echo -n "  wofi: "
if command -v wofi &> /dev/null; then
    echo "✓"
else
    echo "❌ NON TROUVÉ"
fi

echo -n "  waybar: "
if command -v waybar &> /dev/null; then
    echo "✓"
else
    echo "❌ NON TROUVÉ"
fi

echo ""
echo "2. Lancer Waybar si non lancé:"
if ! pgrep waybar > /dev/null; then
    echo "  Lancement de waybar..."
    waybar &
    sleep 2
    if pgrep waybar > /dev/null; then
        echo "  ✓ Waybar lancé"
    else
        echo "  ❌ Waybar n'a pas démarré"
    fi
else
    echo "  ✓ Waybar déjà lancé"
fi

echo ""
echo "3. Test de lancement d'application via hyprctl:"
echo "  Tentative de lancement de kitty..."
hyprctl dispatch exec kitty 2>&1

sleep 2

if pgrep kitty > /dev/null; then
    echo "  ✓ Kitty lancé avec succès!"
    echo "  Fermeture..."
    pkill kitty
else
    echo "  ❌ Kitty n'a pas démarré"
    echo ""
    echo "  Vérification des erreurs Hyprland:"
    HYPR_LOG=$(ls -t /tmp/hypr/*/hyprland.log 2>/dev/null | head -1)
    if [ -f "$HYPR_LOG" ]; then
        tail -20 "$HYPR_LOG" | grep -i "error\|exec"
    fi
fi

echo ""
echo "4. Vérification des keybinds:"
echo "  Keybinds enregistrés pour CTRL:"
hyprctl binds | grep -A 1 "CTRL"

echo ""
echo "5. Configuration active:"
echo "  Fichier config utilisé:"
hyprctl version | grep -i config

echo ""
echo "=== TESTS MANUELS À FAIRE ==="
echo "Essayez ces commandes dans un terminal:"
echo "  1. hyprctl dispatch exec kitty"
echo "  2. hyprctl dispatch exec wofi --show drun"
echo "  3. hyprctl reload"
echo ""
echo "Si rien ne fonctionne, utilisez la config minimale:"
echo "  cp ~/dotfiles/hyprland-minimal.conf ~/.config/hypr/hyprland.conf"
echo "  hyprctl reload"
echo ""
