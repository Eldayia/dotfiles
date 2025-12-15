#!/usr/bin/env bash
# Script pour démarrer Hyprland correctement

echo "=== DÉMARRAGE HYPRLAND ==="
echo ""

# Vérifier qu'on est sur NixOS
if [ ! -f /etc/NIXOS ]; then
    echo "❌ Pas sur NixOS"
    exit 1
fi

# Vérifier qu'on est en TTY (pas déjà dans une session graphique)
if [ -n "$WAYLAND_DISPLAY" ] || [ -n "$DISPLAY" ]; then
    echo "❌ Vous êtes déjà dans une session graphique"
    echo "   WAYLAND_DISPLAY: $WAYLAND_DISPLAY"
    echo "   DISPLAY: $DISPLAY"
    exit 1
fi

echo "✓ En mode TTY, prêt à démarrer Hyprland"
echo ""

# Vérifier que Hyprland est installé
if ! command -v Hyprland &> /dev/null; then
    echo "❌ Hyprland n'est pas installé!"
    echo ""
    echo "Vérifiez que NixOS a bien été rebuild:"
    echo "  sudo nixos-rebuild switch"
    exit 1
fi

echo "✓ Hyprland est installé: $(which Hyprland)"
echo ""

# Vérifier le display manager
echo "Vérification du display manager (Ly):"
if systemctl is-enabled display-manager.service &> /dev/null; then
    echo "✓ Display manager activé"

    if systemctl is-active display-manager.service &> /dev/null; then
        echo "✓ Display manager actif"
        echo ""
        echo "Le display manager Ly tourne déjà."
        echo "Vous devriez voir un écran de connexion graphique."
        echo ""
        echo "Si vous ne le voyez pas, redémarrez:"
        echo "  sudo reboot"
    else
        echo "⚠️  Display manager pas actif"
        echo ""
        echo "Démarrage du display manager:"
        sudo systemctl start display-manager.service

        if systemctl is-active display-manager.service &> /dev/null; then
            echo "✓ Display manager démarré"
        else
            echo "❌ Échec du démarrage"
            echo ""
            echo "Logs d'erreur:"
            sudo journalctl -u display-manager -n 20
        fi
    fi
else
    echo "❌ Display manager pas activé"
    echo ""
    echo "Activation du display manager:"
    sudo systemctl enable display-manager.service
    sudo systemctl start display-manager.service
fi

echo ""
echo "=== ALTERNATIVE: Lancement manuel ==="
echo ""
echo "Si le display manager ne fonctionne pas, vous pouvez lancer"
echo "Hyprland manuellement avec:"
echo ""
echo "  Hyprland"
echo ""
echo "Ou avec dbus:"
echo ""
echo "  dbus-run-session Hyprland"
echo ""
read -p "Voulez-vous lancer Hyprland maintenant? (o/N) " -n 1 -r
echo ""

if [[ $REPLY =~ ^[OoYy]$ ]]; then
    echo "Lancement de Hyprland..."
    echo ""
    exec Hyprland
fi
