# ============================================================
# ZSH
# ============================================================

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(
    git
    sudo
    extract
    colored-man-pages
)

source "$ZSH/oh-my-zsh.sh"


# ============================================================
# ARCH ZSH PLUGINS
# ============================================================

[[ -f /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ]] &&
    source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

[[ -f /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]] &&
    source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh


# ============================================================
# POWERLEVEL10K
# ============================================================

[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh


# ============================================================
# ENV
# ============================================================

export EDITOR=nvim
export VISUAL=nvim

export PATH="$HOME/.local/bin:$PATH"


# ============================================================
# ALIASES
# ============================================================

alias ls='ls --color=auto'
alias ll='ls -lah'
alias cls='clear'

alias g='git'
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git log --oneline --graph --decorate'

alias v='nvim'
alias vi='nvim'
alias vim='nvim'
