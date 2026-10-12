# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ============================================================
# ZSH
# ============================================================


# ============================================================
# USER CONFIG
# ============================================================


# ------------------------------------------------------------
# Environment
# ------------------------------------------------------------

[[ -f "$HOME/.config/zsh/env.zsh" ]] &&
    source "$HOME/.config/zsh/env.zsh"


# ------------------------------------------------------------
# Zsh options
# ------------------------------------------------------------

[[ -f "$HOME/.config/zsh/options.zsh" ]] &&
    source "$HOME/.config/zsh/options.zsh"


# ============================================================
# OH MY ZSH
# ============================================================

export ZSH="$HOME/.oh-my-zsh"

# Prompt géré par Starship (tools.zsh)
ZSH_THEME="powerlevel10k/powerlevel10k"


# ------------------------------------------------------------
# Oh My Zsh behavior
# ------------------------------------------------------------

CASE_SENSITIVE="false"

HYPHEN_INSENSITIVE="true"

HIST_STAMPS="yyyy-mm-dd"

DISABLE_AUTO_TITLE="false"

DISABLE_MAGIC_FUNCTIONS="false"


# ------------------------------------------------------------
# Oh My Zsh updates
# ------------------------------------------------------------

zstyle ':omz:update' mode reminder

zstyle ':omz:update' frequency 7


# ============================================================
# OH MY ZSH PLUGINS
# ============================================================

plugins=(

    # --------------------------------------------------------
    # Git
    # --------------------------------------------------------

    git
    gitfast
    gh
    gitignore


    # --------------------------------------------------------
    # Arch / Linux
    # --------------------------------------------------------

    archlinux
    systemd
    sudo
    command-not-found


    # --------------------------------------------------------
    # Shell conveniences
    # --------------------------------------------------------

    aliases
    common-aliases

    colored-man-pages

    extract

    copyfile
    copypath
    copybuffer

    dirhistory
    history

    safe-paste


    # --------------------------------------------------------
    # Data / utilities
    # --------------------------------------------------------

    encode64
    jsontools
    urltools
    web-search
    rsync


    # --------------------------------------------------------
    # Development
    # --------------------------------------------------------

    python
    pip

    node
    npm

    rust
    golang


    # --------------------------------------------------------
    # Containers
    # --------------------------------------------------------

    docker
    docker-compose


    # --------------------------------------------------------
    # Environments
    # --------------------------------------------------------

    direnv


    # --------------------------------------------------------
    # UX
    # --------------------------------------------------------

    fancy-ctrl-z


    # --------------------------------------------------------
    # Completion
    # --------------------------------------------------------

    fzf-tab
)


# ------------------------------------------------------------
# Load Oh My Zsh
# ------------------------------------------------------------

if [[ -f "$ZSH/oh-my-zsh.sh" ]]; then
    source "$ZSH/oh-my-zsh.sh"
fi


# ============================================================
# CUSTOM CONFIG
# ============================================================

for config_file in \
    "$HOME/.config/zsh/completion.zsh" \
    "$HOME/.config/zsh/aliases.zsh" \
    "$HOME/.config/zsh/functions.zsh" \
    "$HOME/.config/zsh/tools.zsh"
do
    [[ -f "$config_file" ]] && source "$config_file"
done


# ============================================================
# EXTERNAL ZSH PLUGINS
# ============================================================


# ------------------------------------------------------------
# Autosuggestions
# ------------------------------------------------------------

if [[ -f /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ]]; then
    source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
fi


# ------------------------------------------------------------
# History substring search
# ------------------------------------------------------------

if [[ -f /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh ]]; then
    source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
fi


# ------------------------------------------------------------
# Keybindings
#
# Loaded after history-substring-search so its widgets exist.
# ------------------------------------------------------------

[[ -f "$HOME/.config/zsh/keybindings.zsh" ]] &&
    source "$HOME/.config/zsh/keybindings.zsh"


# ------------------------------------------------------------
# Syntax highlighting
#
# Keep close to the end of .zshrc.
# ------------------------------------------------------------

if [[ -f /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]]; then
    source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
