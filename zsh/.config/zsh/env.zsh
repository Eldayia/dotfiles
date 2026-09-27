# ============================================================
# ENVIRONMENT
# ============================================================


# ------------------------------------------------------------
# Locale
# ------------------------------------------------------------

export LANG="fr_FR.UTF-8"

# Ne mets LC_ALL que si tu veux réellement tout forcer en français.
# export LC_ALL="fr_FR.UTF-8"
export USER42="camjouan"
export MAIL42="camjouan@learner.42.tech"

# ------------------------------------------------------------
# Editors
# ------------------------------------------------------------

export EDITOR="nvim"
export VISUAL="nvim"


# ------------------------------------------------------------
# Pager
# ------------------------------------------------------------

export PAGER="less"
export LESS="-R"


# ------------------------------------------------------------
# Browser
# ------------------------------------------------------------

export BROWSER="zen-browser"


# ============================================================
# XDG
# ============================================================

export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"


# ============================================================
# DEVELOPMENT
# ============================================================


# Rust
export CARGO_HOME="$HOME/.cargo"
export RUSTUP_HOME="$HOME/.rustup"


# Go
export GOPATH="$HOME/go"


# pnpm
export PNPM_HOME="$HOME/.local/share/pnpm"


# ============================================================
# PATH
# ============================================================

typeset -U path PATH

path=(
    "$HOME/.local/bin"
    "$HOME/bin"

    "$CARGO_HOME/bin"
    "$GOPATH/bin"
    "$PNPM_HOME"

    $path
)

export PATH


# ============================================================
# TOOLS
# ============================================================

export RIPGREP_CONFIG_PATH="$XDG_CONFIG_HOME/ripgrep/config"

export LESSHISTFILE="$XDG_STATE_HOME/less/history"

export CLICOLOR=1
export COLORTERM=truecolor
