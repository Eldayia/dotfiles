#!/usr/bin/env bash
# Script de collecte et envoi des logs Hyprland

HASTEBIN_URL="https://paste.eldadev.fr"
OUTPUT_FILE="/tmp/hyprland-debug-$(date +%Y%m%d-%H%M%S).log"

echo "=== COLLECTE DES LOGS HYPRLAND ===" | tee "$OUTPUT_FILE"
echo "" | tee -a "$OUTPUT_FILE"
echo "Date: $(date)" | tee -a "$OUTPUT_FILE"
echo "Host: $(hostname)" | tee -a "$OUTPUT_FILE"
echo "" | tee -a "$OUTPUT_FILE"

# 1. Informations système
echo "========================================" | tee -a "$OUTPUT_FILE"
echo "1. INFORMATIONS SYSTÈME" | tee -a "$OUTPUT_FILE"
echo "========================================" | tee -a "$OUTPUT_FILE"
uname -a | tee -a "$OUTPUT_FILE"
echo "" | tee -a "$OUTPUT_FILE"

# 2. Environnement
echo "========================================" | tee -a "$OUTPUT_FILE"
echo "2. VARIABLES D'ENVIRONNEMENT" | tee -a "$OUTPUT_FILE"
echo "========================================" | tee -a "$OUTPUT_FILE"
env | grep -E "WAYLAND|XDG|DISPLAY|PATH" | sort | tee -a "$OUTPUT_FILE"
echo "" | tee -a "$OUTPUT_FILE"

# 3. Processus en cours
echo "========================================" | tee -a "$OUTPUT_FILE"
echo "3. PROCESSUS GRAPHIQUES" | tee -a "$OUTPUT_FILE"
echo "========================================" | tee -a "$OUTPUT_FILE"
ps aux | grep -E "Hyprland|waybar|dunst|wofi" | grep -v grep | tee -a "$OUTPUT_FILE"
echo "" | tee -a "$OUTPUT_FILE"

# 4. Services systemd
echo "========================================" | tee -a "$OUTPUT_FILE"
echo "4. SERVICES SYSTEMD" | tee -a "$OUTPUT_FILE"
echo "========================================" | tee -a "$OUTPUT_FILE"
systemctl status display-manager --no-pager 2>&1 | tee -a "$OUTPUT_FILE"
echo "" | tee -a "$OUTPUT_FILE"

# 5. Logs Hyprland
echo "========================================" | tee -a "$OUTPUT_FILE"
echo "5. LOGS HYPRLAND" | tee -a "$OUTPUT_FILE"
echo "========================================" | tee -a "$OUTPUT_FILE"
HYPR_LOG=$(ls -t /tmp/hypr/*/hyprland.log 2>/dev/null | head -1)
if [ -f "$HYPR_LOG" ]; then
    echo "Fichier: $HYPR_LOG" | tee -a "$OUTPUT_FILE"
    echo "" | tee -a "$OUTPUT_FILE"
    echo "--- Dernières 100 lignes ---" | tee -a "$OUTPUT_FILE"
    tail -100 "$HYPR_LOG" | tee -a "$OUTPUT_FILE"
else
    echo "❌ Aucun log Hyprland trouvé" | tee -a "$OUTPUT_FILE"
fi
echo "" | tee -a "$OUTPUT_FILE"

# 6. Logs journalctl
echo "========================================" | tee -a "$OUTPUT_FILE"
echo "6. LOGS SYSTÈME (journalctl)" | tee -a "$OUTPUT_FILE"
echo "========================================" | tee -a "$OUTPUT_FILE"
journalctl -b | grep -i hypr | tail -50 | tee -a "$OUTPUT_FILE"
echo "" | tee -a "$OUTPUT_FILE"

# 7. Configuration Hyprland
echo "========================================" | tee -a "$OUTPUT_FILE"
echo "7. CONFIGURATION HYPRLAND" | tee -a "$OUTPUT_FILE"
echo "========================================" | tee -a "$OUTPUT_FILE"
if [ -f ~/.config/hypr/hyprland.conf ]; then
    cat ~/.config/hypr/hyprland.conf | tee -a "$OUTPUT_FILE"
else
    echo "❌ Configuration non trouvée" | tee -a "$OUTPUT_FILE"
fi
echo "" | tee -a "$OUTPUT_FILE"

# 8. Applications installées
echo "========================================" | tee -a "$OUTPUT_FILE"
echo "8. APPLICATIONS DISPONIBLES" | tee -a "$OUTPUT_FILE"
echo "========================================" | tee -a "$OUTPUT_FILE"
for app in Hyprland waybar dunst wofi kitty warp-terminal; do
    echo -n "$app: " | tee -a "$OUTPUT_FILE"
    if command -v "$app" &> /dev/null; then
        which "$app" | tee -a "$OUTPUT_FILE"
    else
        echo "NON TROUVÉ" | tee -a "$OUTPUT_FILE"
    fi
done
echo "" | tee -a "$OUTPUT_FILE"

echo "========================================" | tee -a "$OUTPUT_FILE"
echo "FIN DE LA COLLECTE" | tee -a "$OUTPUT_FILE"
echo "========================================" | tee -a "$OUTPUT_FILE"
echo "" | tee -a "$OUTPUT_FILE"

# Sauvegarder localement
echo "✓ Logs sauvegardés dans: $OUTPUT_FILE"
echo ""

# Envoyer sur Hastebin
echo "📤 Envoi sur Hastebin..."
RESPONSE=$(curl -s -X POST -d "$(cat "$OUTPUT_FILE")" "$HASTEBIN_URL/documents")

if [ $? -eq 0 ]; then
    # Extraire la clé
    KEY=$(echo "$RESPONSE" | grep -o '"key":"[^"]*' | cut -d'"' -f4)

    if [ -n "$KEY" ]; then
        URL="$HASTEBIN_URL/$KEY"
        echo "✓ Logs envoyés avec succès!"
        echo ""
        echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
        echo "📋 URL: $URL"
        echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
        echo ""
        echo "Copiez cette URL et envoyez-la moi."
    else
        echo "❌ Erreur: impossible d'extraire la clé"
        echo "Réponse: $RESPONSE"
    fi
else
    echo "❌ Erreur lors de l'envoi"
    echo ""
    echo "Vous pouvez consulter les logs localement:"
    echo "  cat $OUTPUT_FILE"
    echo ""
    echo "Ou les envoyer manuellement:"
    echo "  curl -X POST -d \"@$OUTPUT_FILE\" $HASTEBIN_URL/documents"
fi

echo ""
echo "Fichier local conservé: $OUTPUT_FILE"
