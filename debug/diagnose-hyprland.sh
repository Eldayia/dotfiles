#!/usr/bin/env bash
# Script de diagnostic Hyprland

echo "======================================"
echo "   DIAGNOSTIC HYPRLAND"
echo "======================================"
echo ""

# 1. Vérifier qu'on est sur NixOS
echo "=== 1. Système ==="
if [ -f /etc/NIXOS ]; then
    echo "✓ NixOS détecté"
else
    echo "❌ Pas sur NixOS"
    exit 1
fi
echo ""

# 2. Vérifier l'environnement Hyprland
echo "=== 2. Environnement Wayland ==="
echo "WAYLAND_DISPLAY: ${WAYLAND_DISPLAY:-[non défini]}"
echo "XDG_CURRENT_DESKTOP: ${XDG_CURRENT_DESKTOP:-[non défini]}"
echo "XDG_SESSION_TYPE: ${XDG_SESSION_TYPE:-[non défini]}"
echo ""

# 3. Vérifier que Hyprland tourne
echo "=== 3. Processus Hyprland ==="
if pgrep -x Hyprland > /dev/null; then
    echo "✓ Hyprland est en cours d'exécution (PID: $(pgrep -x Hyprland))"
else
    echo "❌ Hyprland ne tourne pas!"
    exit 1
fi
echo ""

# 4. Vérifier les services
echo "=== 4. Services ==="
echo -n "Waybar: "
if pgrep -x waybar > /dev/null; then
    echo "✓ En cours (PID: $(pgrep -x waybar))"
else
    echo "❌ Non lancé"
fi

echo -n "Dunst: "
if pgrep -x dunst > /dev/null; then
    echo "✓ En cours (PID: $(pgrep -x dunst))"
else
    echo "❌ Non lancé"
fi

echo -n "Wofi: "
if pgrep -x wofi > /dev/null; then
    echo "✓ En cours (PID: $(pgrep -x wofi))"
else
    echo "⚠️  Non lancé (normal si non utilisé)"
fi
echo ""

# 5. Vérifier que les applications existent
echo "=== 5. Applications disponibles ==="
APPS=("warp-terminal" "kitty" "wofi" "waybar" "dunst" "microsoft-edge" "yazi")

for app in "${APPS[@]}"; do
    echo -n "$app: "
    if command -v "$app" &> /dev/null; then
        echo "✓ $(which "$app")"
    else
        echo "❌ NON TROUVÉ"
    fi
done
echo ""

# 6. Vérifier la configuration Hyprland
echo "=== 6. Configuration Hyprland ==="
if [ -f ~/.config/hypr/hyprland.conf ]; then
    echo "✓ Fichier de configuration trouvé"

    # Vérifier si c'est un lien symbolique
    if [ -L ~/.config/hypr/hyprland.conf ]; then
        echo "✓ Lien symbolique vers: $(readlink ~/.config/hypr/hyprland.conf)"
    else
        echo "⚠️  Fichier normal (pas un lien symbolique)"
    fi
else
    echo "❌ Fichier de configuration manquant!"
fi
echo ""

# 7. Tester les commandes manuellement
echo "=== 7. Test des commandes ==="
echo "Test de wofi:"
timeout 2s wofi --show drun --no-actions &> /dev/null &
WOFI_PID=$!
sleep 1
if ps -p $WOFI_PID > /dev/null 2>&1; then
    echo "✓ Wofi peut se lancer"
    kill $WOFI_PID 2>/dev/null
else
    echo "❌ Wofi ne se lance pas"
fi

echo ""
echo "Test de warp-terminal:"
if command -v warp-terminal &> /dev/null; then
    echo "✓ Commande existe"
else
    echo "❌ Commande non trouvée"
fi
echo ""

# 8. Vérifier les logs Hyprland récents
echo "=== 8. Logs Hyprland (dernières erreurs) ==="
HYPR_LOG=$(ls -t /tmp/hypr/*/hyprland.log 2>/dev/null | head -1)
if [ -f "$HYPR_LOG" ]; then
    echo "Fichier de log: $HYPR_LOG"
    echo ""
    echo "Dernières erreurs:"
    grep -i "error\|critical\|fatal" "$HYPR_LOG" | tail -10
    echo ""
else
    echo "❌ Aucun log trouvé"
fi

# 9. Vérifier hyprctl
echo "=== 9. Test hyprctl ==="
echo "Fenêtres actives:"
hyprctl clients | grep -E "class:|title:" | head -6

echo ""
echo "Keybinds actifs (premiers 10):"
hyprctl binds | head -10

echo ""
echo "======================================"
echo "   FIN DU DIAGNOSTIC"
echo "======================================"
echo ""
echo "ACTIONS RECOMMANDÉES:"
echo ""

# Recommandations basées sur les résultats
if ! pgrep -x waybar > /dev/null; then
    echo "1. Lancer Waybar manuellement:"
    echo "   waybar &"
    echo ""
fi

if ! command -v warp-terminal &> /dev/null; then
    echo "2. warp-terminal n'est pas installé. Vérifier:"
    echo "   nixos-rebuild switch"
    echo ""
fi

echo "3. Tester un raccourci manuellement:"
echo "   hyprctl dispatch exec warp-terminal"
echo ""

echo "4. Voir tous les logs en temps réel:"
echo "   tail -f $HYPR_LOG"
echo ""

echo "5. Recharger la configuration:"
echo "   hyprctl reload"
echo ""
