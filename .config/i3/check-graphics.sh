#!/usr/bin/env bash

# Script de diagnostic graphique complet pour i3 + X11

OUTPUT_FILE="/tmp/i3-graphics-check.txt"

{
    echo "=============================================="
    echo "  DIAGNOSTIC GRAPHIQUE i3 + X11"
    echo "  $(date '+%Y-%m-%d %H:%M:%S')"
    echo "=============================================="
    echo ""

    echo "--- 1. SESSION X11 ---"
    echo "DISPLAY: $DISPLAY"
    echo "XDG_SESSION_TYPE: $XDG_SESSION_TYPE"
    echo "XDG_CURRENT_DESKTOP: $XDG_CURRENT_DESKTOP"
    echo ""

    echo "--- 2. INFORMATIONS X SERVER ---"
    if command -v xdpyinfo &> /dev/null; then
        xdpyinfo | grep -E "name of display|version number|vendor string|dimensions|resolution"
    else
        echo "❌ xdpyinfo non disponible"
    fi
    echo ""

    echo "--- 3. OPENGL & MESA ---"
    if command -v glxinfo &> /dev/null; then
        glxinfo -B 2>/dev/null | grep -E "OpenGL vendor|OpenGL renderer|OpenGL version|OpenGL core profile version|Accelerated|Video memory"
    else
        echo "❌ glxinfo non disponible"
    fi
    echo ""

    echo "--- 4. DRIVER VIDÉO ACTIF ---"
    if command -v lspci &> /dev/null; then
        lspci | grep -i vga
        lspci | grep -i vmware
    else
        echo "❌ lspci non disponible"
    fi
    echo ""

    echo "--- 5. MODULES KERNEL (VMware) ---"
    lsmod | grep -E "vmwgfx|drm|vmw" || echo "Aucun module VMware détecté"
    echo ""

    echo "--- 6. VARIABLES D'ENVIRONNEMENT GRAPHIQUES ---"
    echo "LIBGL_ALWAYS_SOFTWARE: $LIBGL_ALWAYS_SOFTWARE"
    echo "MESA_LOADER_DRIVER_OVERRIDE: $MESA_LOADER_DRIVER_OVERRIDE"
    echo "QT_QPA_PLATFORM: $QT_QPA_PLATFORM"
    echo "GDK_BACKEND: $GDK_BACKEND"
    echo ""

    echo "--- 7. PROCESSUS i3 ---"
    ps aux | grep -E "i3|i3status|i3bar|dunst" | grep -v grep || echo "Aucun processus i3 trouvé"
    echo ""

    echo "--- 8. RÉSUMÉ ---"
    ACCELERATED=$(glxinfo -B 2>/dev/null | grep "Accelerated:" | awk '{print $2}')
    RENDERER=$(glxinfo -B 2>/dev/null | grep "OpenGL renderer" | cut -d':' -f2)

    if [ "$ACCELERATED" = "yes" ]; then
        echo "✅ Accélération matérielle : ACTIVÉE"
        echo "✅ Renderer : $RENDERER"
    else
        echo "⚠️  Accélération matérielle : $ACCELERATED"
        echo "⚠️  Renderer : $RENDERER"
    fi
    echo ""
    echo "Diagnostic sauvegardé dans: $OUTPUT_FILE"

} > "$OUTPUT_FILE"

# Afficher dans un terminal
if command -v kitty &> /dev/null; then
    kitty --title "i3 Graphics Diagnostic" sh -c "cat $OUTPUT_FILE; echo ''; echo 'Appuyez sur Entrée pour fermer...'; read"
elif command -v xterm &> /dev/null; then
    xterm -T "i3 Graphics Diagnostic" -e sh -c "cat $OUTPUT_FILE; echo ''; echo 'Appuyez sur Entrée pour fermer...'; read"
else
    notify-send "i3 Graphics" "Diagnostic sauvegardé dans $OUTPUT_FILE"
fi
