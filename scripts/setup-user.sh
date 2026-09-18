#!/usr/bin/env bash

set -Eeuo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"


echo "======================================"
echo " Oh My Zsh"
echo "======================================"

if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
    git clone \
        https://github.com/ohmyzsh/ohmyzsh.git \
        "$HOME/.oh-my-zsh"
else
    echo "Oh My Zsh déjà installé."
fi


echo
echo "======================================"
echo " Powerlevel10k"
echo "======================================"

P10K="$HOME/.oh-my-zsh/custom/themes/powerlevel10k"

if [[ ! -d "$P10K" ]]; then
    git clone --depth=1 \
        https://github.com/romkatv/powerlevel10k.git \
        "$P10K"
else
    echo "Powerlevel10k déjà installé."
fi


echo
echo "======================================"
echo " Stow : Zsh + environnement"
echo "======================================"

cd "$ROOT"

stow --target="$HOME" zsh
stow --target="$HOME" environment


echo
echo "======================================"
echo " Shell Zsh"
echo "======================================"

if [[ "$SHELL" != "/usr/bin/zsh" ]]; then
    chsh -s /usr/bin/zsh
fi


echo
echo "======================================"
echo " Génération DMS / Niri"
echo "======================================"

if [[ ! -e "$HOME/.config/niri/config.kdl" ]]; then
    dms setup headless \
        --compositor niri \
        --terminal ghostty
else
    dms setup headless \
        --compositor niri \
        --terminal ghostty \
        --skip-existing
fi


echo
echo "======================================"
echo " Import config Niri dans dotfiles"
echo "======================================"

if [[ -d "$HOME/.config/niri" && ! -L "$HOME/.config/niri" ]]; then

    mkdir -p "$ROOT/niri/.config"

    if [[ ! -e "$ROOT/niri/.config/niri" ]]; then
        mv "$HOME/.config/niri" \
           "$ROOT/niri/.config/niri"
    fi
fi


echo
echo "======================================"
echo " Import Ghostty"
echo "======================================"

if [[ -d "$HOME/.config/ghostty" && ! -L "$HOME/.config/ghostty" ]]; then

    mkdir -p "$ROOT/ghostty/.config"

    if [[ ! -e "$ROOT/ghostty/.config/ghostty" ]]; then
        mv "$HOME/.config/ghostty" \
           "$ROOT/ghostty/.config/ghostty"
    fi
fi


echo
echo "======================================"
echo " Stow Niri / Ghostty"
echo "======================================"

cd "$ROOT"

stow --target="$HOME" niri
stow --target="$HOME" ghostty


echo
echo "======================================"
echo " DMS lié à Niri"
echo "======================================"

systemctl --user add-wants niri.service dms.service


echo
echo "======================================"
echo " Validation Niri"
echo "======================================"

niri validate


echo
echo "Configuration utilisateur terminée."
echo
echo "Teste maintenant depuis un TTY :"
echo
echo "  niri-session -l"
