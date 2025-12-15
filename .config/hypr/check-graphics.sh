#!/usr/bin/env bash

# Script de diagnostic graphique avancé pour Hyprland/VMware

LOG_FILE="/tmp/hyprland-graphics-check.log"

{
  echo "=== DIAGNOSTIC GRAPHIQUE HYPRLAND/VMWARE $(date) ==="
  echo ""

  echo "--- 1. Variables d'environnement Wayland/X11 ---"
  echo "WAYLAND_DISPLAY: $WAYLAND_DISPLAY"
  echo "DISPLAY: $DISPLAY"
  echo "XDG_RUNTIME_DIR: $XDG_RUNTIME_DIR"
  echo ""

  echo "--- 2. Modules noyau VMware chargés ---"
  lsmod | grep vmw
  echo ""

  echo "--- 3. Devices DRM disponibles ---"
  ls -la /dev/dri/
  echo ""

  echo "--- 4. Permissions sur /dev/dri ---"
  stat /dev/dri/card0 2>&1 || echo "card0 not found"
  stat /dev/dri/renderD128 2>&1 || echo "renderD128 not found"
  echo ""

  echo "--- 5. Groupes de l'utilisateur ---"
  groups
  echo ""

  echo "--- 6. Test EGL (OpenGL ES) ---"
  eglinfo 2>&1 | head -30 || echo "eglinfo not available"
  echo ""

  echo "--- 7. Informations Mesa/DRI ---"
  glxinfo -B 2>&1 || echo "glxinfo failed"
  echo ""

  echo "--- 8. Renderer wlroots (Hyprland) ---"
  hyprctl systeminfo 2>&1 | grep -i "renderer\|gpu\|driver" || echo "hyprctl systeminfo failed"
  echo ""

  echo "--- 9. Test simple avec weston-terminal (si disponible) ---"
  timeout 2 weston-terminal 2>&1 || echo "weston-terminal not available or failed"
  echo ""

  echo "--- 10. Logs Hyprland récents ---"
  tail -50 /tmp/hypr/$(ls -t /tmp/hypr/ | head -1)/hyprland.log 2>&1 || echo "Hyprland logs not found"
  echo ""

  echo "=== FIN DIAGNOSTIC GRAPHIQUE ==="
} > "$LOG_FILE" 2>&1

# Notification et ouverture
notify-send "Diagnostic Graphique" "Résultats dans $LOG_FILE"
chromium "file://$LOG_FILE" &
