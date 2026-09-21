#!/usr/bin/env bash

set -Eeuo pipefail


# ============================================================
# PATHS
# ============================================================

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

OH_MY_ZSH="$HOME/.oh-my-zsh"

ZSH_CUSTOM="${ZSH_CUSTOM:-$OH_MY_ZSH/custom}"


# ============================================================
# HELPERS
# ============================================================

section() {

    echo
    echo "======================================"
    echo " $1"
    echo "======================================"
    echo

}


command_exists() {

    command -v "$1" >/dev/null 2>&1

}


# ============================================================
# USER DIRECTORIES
# ============================================================

section "Répertoires utilisateur"

mkdir -p \
    "$HOME/.config" \
    "$HOME/.cache/zsh" \
    "$HOME/.local/bin" \
    "$HOME/.local/state/zsh" \
    "$HOME/.local/state/less"


# ============================================================
# OH MY ZSH
# ============================================================

section "Oh My Zsh"

if [[ ! -d "$OH_MY_ZSH" ]]; then

    git clone \
        --depth=1 \
        https://github.com/ohmyzsh/ohmyzsh.git \
        "$OH_MY_ZSH"

else

    echo "Oh My Zsh déjà installé."

fi


# ============================================================
# POWERLEVEL10K
# ============================================================

section "Powerlevel10k"

P10K="$ZSH_CUSTOM/themes/powerlevel10k"

if [[ ! -d "$P10K" ]]; then

    git clone \
        --depth=1 \
        https://github.com/romkatv/powerlevel10k.git \
        "$P10K"

else

    echo "Powerlevel10k déjà installé."

fi


# ============================================================
# FZF-TAB
# ============================================================

section "fzf-tab"

FZF_TAB="$ZSH_CUSTOM/plugins/fzf-tab"

if [[ ! -d "$FZF_TAB" ]]; then

    git clone \
        --depth=1 \
        https://github.com/Aloxaf/fzf-tab.git \
        "$FZF_TAB"

else

    echo "fzf-tab déjà installé."

fi


# ============================================================
# STOW : ZSH + ENVIRONMENT
# ============================================================

section "Stow : Zsh + environnement"

cd "$ROOT"

if [[ -d "$ROOT/zsh" ]]; then

    echo "Installation de zsh..."

    stow \
        --target="$HOME" \
        --restow \
        zsh

fi


if [[ -d "$ROOT/environment" ]]; then

    echo "Installation de environment..."

    stow \
        --target="$HOME" \
        --restow \
        environment

fi


# ============================================================
# DEFAULT SHELL
# ============================================================

section "Shell Zsh"

if command_exists zsh; then

    ZSH_BIN="$(command -v zsh)"

    CURRENT_SHELL="$(getent passwd "$USER" | cut -d: -f7)"

    if [[ "$CURRENT_SHELL" != "$ZSH_BIN" ]]; then

        echo "Définition de $ZSH_BIN comme shell par défaut..."

        chsh -s "$ZSH_BIN"

    else

        echo "Zsh est déjà le shell par défaut."

    fi

else

    echo "ERREUR : zsh introuvable."

    exit 1

fi


# ============================================================
# RUSTUP
# ============================================================

section "Rust"

if command_exists rustup; then

    if ! rustup show active-toolchain >/dev/null 2>&1; then

        echo "Installation de la toolchain Rust stable..."

        rustup default stable

    else

        echo "Toolchain Rust déjà configurée."

    fi

fi


# ============================================================
# PKGFILE
# ============================================================

section "pkgfile"

if command_exists pkgfile; then

    echo "Mise à jour de la base pkgfile..."

    sudo pkgfile -u

fi


# ============================================================
# DMS / NIRI
# ============================================================

section "Génération DMS / Niri"

if command_exists dms; then

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

else

    echo "dms introuvable, étape ignorée."

fi


# ============================================================
# IMPORT NIRI
# ============================================================

section "Import config Niri dans dotfiles"

if [[ -d "$HOME/.config/niri" && ! -L "$HOME/.config/niri" ]]; then

    mkdir -p "$ROOT/niri/.config"

    if [[ ! -e "$ROOT/niri/.config/niri" ]]; then

        echo "Import de ~/.config/niri dans les dotfiles..."

        mv \
            "$HOME/.config/niri" \
            "$ROOT/niri/.config/niri"

    else

        echo "Config Niri déjà présente dans les dotfiles."

    fi

fi


# ============================================================
# IMPORT GHOSTTY
# ============================================================

section "Import Ghostty"

if [[ -d "$HOME/.config/ghostty" && ! -L "$HOME/.config/ghostty" ]]; then

    mkdir -p "$ROOT/ghostty/.config"

    if [[ ! -e "$ROOT/ghostty/.config/ghostty" ]]; then

        echo "Import de ~/.config/ghostty dans les dotfiles..."

        mv \
            "$HOME/.config/ghostty" \
            "$ROOT/ghostty/.config/ghostty"

    else

        echo "Config Ghostty déjà présente dans les dotfiles."

    fi

fi


# ============================================================
# STOW NIRI / GHOSTTY
# ============================================================

section "Stow Niri / Ghostty"

cd "$ROOT"

if [[ -d "$ROOT/niri" ]]; then

    echo "Installation de Niri..."

    stow \
        --target="$HOME" \
        --restow \
        niri

fi


if [[ -d "$ROOT/ghostty" ]]; then

    echo "Installation de Ghostty..."

    stow \
        --target="$HOME" \
        --restow \
        ghostty

fi


# Déployer tous les paquets de configuration présents dans le dépôt.
bash "$ROOT/scripts/stow-configs.sh"
bash "$ROOT/scripts/setup-nautilus.sh"


# ============================================================
# DMS SYSTEMD INTEGRATION
# ============================================================

section "DMS lié à Niri"

if \
    systemctl --user list-unit-files niri.service >/dev/null 2>&1 &&
    systemctl --user list-unit-files dms.service >/dev/null 2>&1
then

    systemctl --user add-wants \
        niri.service \
        dms.service

else

    echo "Services Niri/DMS non disponibles, étape ignorée."

fi


# ============================================================
# DOCKER
# ============================================================

section "Docker"

if command_exists docker; then

    if getent group docker >/dev/null 2>&1; then

        if ! id -nG "$USER" | grep -qw docker; then

            echo "Ajout de $USER au groupe docker..."

            sudo usermod \
                -aG docker \
                "$USER"

            echo
            echo "NOTE : la nouvelle appartenance au groupe Docker"
            echo "sera appliquée à la prochaine reconnexion."

        else

            echo "Utilisateur déjà membre du groupe docker."

        fi

    fi

fi


# ============================================================
# VALIDATE ZSH
# ============================================================

section "Validation Zsh"

if command_exists zsh && [[ -f "$HOME/.zshrc" ]]; then

    if zsh -n "$HOME/.zshrc"; then

        echo "Syntaxe ~/.zshrc : OK"

    else

        echo "ERREUR : syntaxe invalide dans ~/.zshrc"

        exit 1

    fi

fi


# ============================================================
# VALIDATE NIRI
# ============================================================

section "Validation Niri"

if command_exists niri; then

    if niri validate; then

        echo "Configuration Niri : OK"

    else

        echo "ERREUR : configuration Niri invalide."

        exit 1

    fi

else

    echo "niri introuvable, validation ignorée."

fi


# ============================================================
# SUMMARY
# ============================================================

section "Configuration utilisateur terminée"

echo "Dotfiles :"
echo
echo "  $ROOT"
echo

echo "Shell :"
echo
echo "  $ZSH_BIN"
echo

echo "Tu peux recharger Zsh avec :"
echo
echo "  exec zsh"
echo

echo "Pour tester Niri depuis un TTY :"
echo
echo "  niri-session -l"
echo
