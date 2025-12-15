#!/usr/bin/env bash

# Script de diagnostic des variables d'environnement pour i3

OUTPUT_FILE="/tmp/i3-debug-env.txt"

{
    echo "==================================="
    echo "  DIAGNOSTIC VARIABLES D'ENVIRONNEMENT i3"
    echo "  $(date '+%Y-%m-%d %H:%M:%S')"
    echo "==================================="
    echo ""

    echo "--- DISPLAY & SESSION ---"
    echo "DISPLAY: $DISPLAY"
    echo "XDG_SESSION_TYPE: $XDG_SESSION_TYPE"
    echo "XDG_CURRENT_DESKTOP: $XDG_CURRENT_DESKTOP"
    echo "XDG_SESSION_DESKTOP: $XDG_SESSION_DESKTOP"
    echo ""

    echo "--- X11 CONFIGURATION ---"
    echo "XAUTHORITY: $XAUTHORITY"
    echo "XCURSOR_SIZE: $XCURSOR_SIZE"
    echo ""

    echo "--- GRAPHICS ---"
    echo "LIBGL_ALWAYS_SOFTWARE: $LIBGL_ALWAYS_SOFTWARE"
    echo "MESA_LOADER_DRIVER_OVERRIDE: $MESA_LOADER_DRIVER_OVERRIDE"
    echo ""

    echo "--- TOOLKIT ---"
    echo "QT_QPA_PLATFORM: $QT_QPA_PLATFORM"
    echo "GDK_BACKEND: $GDK_BACKEND"
    echo ""

    echo "--- PATH ---"
    echo "PATH: $PATH"
    echo ""

    echo "--- SHELL ---"
    echo "SHELL: $SHELL"
    echo "TERM: $TERM"
    echo ""

} > "$OUTPUT_FILE"

# Afficher dans un terminal
if command -v kitty &> /dev/null; then
    kitty --title "i3 Debug Environment" sh -c "cat $OUTPUT_FILE; echo ''; echo 'Appuyez sur Entrée pour fermer...'; read"
elif command -v xterm &> /dev/null; then
    xterm -T "i3 Debug Environment" -e sh -c "cat $OUTPUT_FILE; echo ''; echo 'Appuyez sur Entrée pour fermer...'; read"
else
    # Fallback: afficher dans une notification
    notify-send "i3 Debug" "Variables d'environnement sauvegardées dans $OUTPUT_FILE"
fi
