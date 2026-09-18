#!/usr/bin/env bash

set -Eeuo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
PACMAN_LIST="$ROOT/packages/pacman.txt"
AUR_LIST="$ROOT/packages/aur.txt"

if [[ ! -f /etc/arch-release ]]; then
    echo "Erreur : ce script est prévu pour Arch Linux."
    exit 1
fi

if [[ $EUID -eq 0 ]]; then
    echo "Ne lance pas ce script en root."
    echo "Lance-le avec ton utilisateur normal."
    exit 1
fi


echo "======================================"
echo " Mise à jour Arch"
echo "======================================"

sudo pacman -Syu


echo
echo "======================================"
echo " Installation paquets officiels"
echo "======================================"

mapfile -t PACMAN_PACKAGES < <(
    grep -Ev '^[[:space:]]*(#|$)' "$PACMAN_LIST"
)

sudo pacman -S --needed "${PACMAN_PACKAGES[@]}"


echo
echo "======================================"
echo " Installation de paru"
echo "======================================"

if ! command -v paru >/dev/null 2>&1; then
    TMPDIR_PARU="$(mktemp -d)"

    git clone \
        https://aur.archlinux.org/paru.git \
        "$TMPDIR_PARU/paru"

    (
        cd "$TMPDIR_PARU/paru"
        makepkg -si
    )

    rm -rf "$TMPDIR_PARU"
else
    echo "paru déjà installé."
fi


echo
echo "======================================"
echo " Installation Niri-Spicy"
echo "======================================"

paru -S --needed niri-spicy-git


echo
echo "======================================"
echo " Vérification provider niri"
echo "======================================"

if ! pacman -T niri >/dev/null 2>&1; then
    echo
    echo "ERREUR : niri-spicy-git ne satisfait pas actuellement"
    echo "la dépendance virtuelle 'niri'."
    echo
    echo "Je refuse d'installer dms-shell-niri pour éviter que"
    echo "Pacman remplace Niri-Spicy par Niri vanilla."
    exit 1
fi

echo "niri-spicy-git satisfait la dépendance niri : OK"


echo
echo "======================================"
echo " Installation DMS pour Niri"
echo "======================================"

sudo pacman -S --needed dms-shell-niri


echo
echo "======================================"
echo " Installation paquets AUR"
echo "======================================"

mapfile -t AUR_PACKAGES < <(
    grep -Ev '^[[:space:]]*(#|$)' "$AUR_LIST"
)

paru -S --needed "${AUR_PACKAGES[@]}"


echo
echo "======================================"
echo " Activation services système"
echo "======================================"

sudo systemctl enable --now NetworkManager
sudo systemctl enable --now bluetooth
sudo systemctl enable --now power-profiles-daemon

sudo systemctl enable fstrim.timer


echo
echo "======================================"
echo " Dossiers utilisateur"
echo "======================================"

xdg-user-dirs-update


echo
echo "======================================"
echo " Installation système terminée"
echo "======================================"

echo
echo "Niri :"
niri --version || true

echo
echo "DMS :"
dms --version || true

echo
echo "Étape suivante :"
echo "  $ROOT/scripts/setup-user.sh"
