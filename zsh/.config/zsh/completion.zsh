# ============================================================
# ZSH COMPLETION
# ============================================================

zstyle ':completion:*' menu select


# ------------------------------------------------------------
# Completers
# ------------------------------------------------------------

zstyle ':completion:*' completer \
    _extensions \
    _complete \


# ------------------------------------------------------------
# Case-insensitive matching
# ------------------------------------------------------------

zstyle ':completion:*' matcher-list \
    '' \
    'm:{a-zA-Z}={A-Za-z}' \
    'r:|[._-]=* r:|=*'


# ------------------------------------------------------------
# Formatting
# ------------------------------------------------------------

zstyle ':completion:*' group-name ''

zstyle ':completion:*:descriptions' format '[%d]'

zstyle ':completion:*:messages' format '%d'

zstyle ':completion:*:warnings' format 'No matches found'

# ------------------------------------------------------------
# Colors
# ------------------------------------------------------------

zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"


# ------------------------------------------------------------
# Completion cache
# ------------------------------------------------------------

zstyle ':completion:*' use-cache on

zstyle ':completion:*' cache-path \
    "${XDG_CACHE_HOME:-$HOME/.cache}/zsh/completion"


# ------------------------------------------------------------
# Filesystem
# ------------------------------------------------------------

# Include dotfiles and hidden directories in TAB/fzf-tab results.
zstyle ':completion:*' glob-dots true

zstyle ':completion:*' special-dirs true
zstyle ':completion:*' squeeze-slashes true


# ------------------------------------------------------------
# Processes
# ------------------------------------------------------------

zstyle ':completion:*:*:kill:*:processes' command \
    'ps -u $USER -o pid,user,comm -w -w'

# ============================================================
# FZF-TAB
# ============================================================

zstyle ':fzf-tab:*' fzf-command fzf

zstyle ':fzf-tab:*' switch-group '<' '>'

zstyle ':fzf-tab:*' fzf-flags \
    --height=70% \
    --layout=reverse \
    --border


# ------------------------------------------------------------
# Groups
# ------------------------------------------------------------

zstyle ':fzf-tab:*' group-colors \
    $'\033[01;33m' \
    $'\033[01;34m' \
    $'\033[01;35m' \
    $'\033[01;36m' \
    $'\033[01;32m'


# ------------------------------------------------------------
# cd previews
# ------------------------------------------------------------

zstyle ':fzf-tab:complete:cd:*' fzf-preview \
    'eza --tree --level=2 --all --color=always --icons=always "$realpath" 2>/dev/null'


# ------------------------------------------------------------
# Generic previews
# ------------------------------------------------------------

zstyle ':fzf-tab:complete:*:*' fzf-preview \
    'if [[ -d "$realpath" ]]; then
        eza --tree --level=2 --all --color=always --icons=always "$realpath" 2>/dev/null
     elif [[ -f "$realpath" ]]; then
        bat --color=always --style=numbers --line-range=:200 "$realpath" 2>/dev/null
     fi'
