#!/usr/bin/env bash

# Script de diagnostic - logs les variables d'environnement

LOG_FILE="/tmp/hyprland-env-debug.log"

{
  echo "=== DIAGNOSTIC HYPRLAND $(date) ==="
  echo ""
  echo "--- Variables d'environnement critiques ---"
  echo "WAYLAND_DISPLAY: $WAYLAND_DISPLAY"
  echo "XDG_RUNTIME_DIR: $XDG_RUNTIME_DIR"
  echo "XDG_CURRENT_DESKTOP: $XDG_CURRENT_DESKTOP"
  echo "XDG_SESSION_TYPE: $XDG_SESSION_TYPE"
  echo "DISPLAY: $DISPLAY"
  echo ""
  echo "--- Sockets Wayland disponibles ---"
  ls -la "$XDG_RUNTIME_DIR" | grep wayland
  echo ""
  echo "--- Processus Hyprland ---"
  ps aux | grep -i hyprland | grep -v grep
  echo ""
  echo "--- Test de lancement kitty ---"
  kitty --version 2>&1 || echo "kitty command failed"
  echo ""
  echo "--- PATH ---"
  echo "$PATH"
  echo ""
  echo "=== FIN DIAGNOSTIC ==="
} > "$LOG_FILE" 2>&1

# Notification
notify-send "Debug" "Logs sauvegardés dans $LOG_FILE"

# Ouvrir le fichier avec chromium
chromium "file://$LOG_FILE" &
