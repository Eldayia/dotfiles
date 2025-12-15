#!/usr/bin/env bash

# Script de vérification de l'accélération 3D VMware
# À exécuter sur la VM NixOS pour vérifier que l'accélération GPU fonctionne

echo "=============================================="
echo "  TEST ACCÉLÉRATION 3D VMWARE"
echo "=============================================="
echo ""

echo "--- 1. Accélération matérielle et mémoire vidéo ---"
glxinfo -B 2>/dev/null | grep -E "Accelerated|Video memory|Vendor|Device|Version|OpenGL renderer" || echo "❌ glxinfo failed"
echo ""

echo "--- 2. Carte graphique détectée ---"
lspci | grep -i vga
echo ""

echo "--- 3. Driver graphique utilisé ---"
lspci -k | grep -A 3 -i vga
echo ""

echo "--- 4. Module noyau vmwgfx ---"
if lsmod | grep -q vmwgfx; then
    echo "✅ Module vmwgfx chargé"
    lsmod | grep vmwgfx
else
    echo "❌ Module vmwgfx non chargé"
fi
echo ""

echo "--- 5. Devices DRM disponibles ---"
ls -la /dev/dri/ 2>/dev/null || echo "❌ Pas de devices DRM"
echo ""

echo "--- 6. Résumé ---"
ACCELERATED=$(glxinfo -B 2>/dev/null | grep "Accelerated:" | awk '{print $2}')
VRAM=$(glxinfo -B 2>/dev/null | grep "Video memory:" | awk '{print $3}')

if [ "$ACCELERATED" = "yes" ]; then
    echo "✅ Accélération 3D : ACTIVÉE"
    echo "✅ Mémoire vidéo : $VRAM"
    echo ""
    echo "🎉 L'accélération 3D VMware fonctionne correctement!"
else
    echo "❌ Accélération 3D : DÉSACTIVÉE (ou $ACCELERATED)"
    echo "⚠️  Mémoire vidéo : $VRAM"
    echo ""
    echo "⚠️  L'accélération 3D VMware ne fonctionne pas."
    echo "   Vérifiez les paramètres VMware :"
    echo "   - VM Settings → Display → Accelerate 3D graphics (doit être coché)"
    echo "   - Graphics memory : au moins 128 MB ou 256 MB"
fi
echo ""
echo "=============================================="
