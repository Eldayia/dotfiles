# ============================================================
# EDITORS
# ============================================================

alias v='nvim'
alias n='nvim'
alias vi='nvim'
alias vim='nvim'


alias zshrc='nvim ~/.zshrc'

alias zshconfig='nvim ~/.config/zsh'


# ============================================================
# EZA
# ============================================================

alias l='eza --icons=always --group-directories-first'

alias ll='eza -lah --icons=always --git --group-directories-first'

alias la='eza -a --icons=always --group-directories-first'

alias lt='eza --tree --level=2 --icons=always --group-directories-first'

alias ltt='eza --tree --level=3 --icons=always --group-directories-first'


# ============================================================
# BAT
# ============================================================

alias cat='bat --paging=never'

alias catp='bat'


# ============================================================
# SYSTEM
# ============================================================

alias top='btop'

alias disk='duf'

alias usage='dust'

alias processes='procs'

alias ports='ss -tulpn'

alias iplocal='ip -brief address'

alias ff='fastfetch'

# ============================================================
# GIT
# ============================================================

alias lg='lazygit'

alias gd='git diff'

alias gds='git diff --staged'

alias gl='git log --oneline --graph --decorate'

alias groot='cd "$(git rev-parse --show-toplevel)"'


# ============================================================
# PACMAN
# ============================================================

alias pac='sudo pacman'

alias paci='sudo pacman -S'

alias pacr='sudo pacman -Rns'

alias pacu='sudo pacman -Syu'

alias pacs='pacman -Ss'

alias pacq='pacman -Qs'

alias orphans='pacman -Qtdq'


# ============================================================
# YAY
# ============================================================

if (( $+commands[yay] )); then

    alias yi='yay -S'

    alias yu='yay -Syu'

    alias ys='yay -Ss'

    alias yr='yay -Rns'

fi


# ============================================================
# DOCKER
# ============================================================

alias d='docker'

alias dc='docker compose'

alias dps='docker ps'

alias dpa='docker ps -a'

alias di='docker images'

alias dex='docker exec -it'

alias dlogs='docker logs -f'


# ============================================================
# PYTHON
# ============================================================

alias py='python'

alias pip='python -m pip'


# ============================================================
# GENERAL
# ============================================================

alias c='clear'

alias reload='exec zsh'

alias path='print -l $path'

# Terminal applications
alias bt='btop'
alias ld='lazydocker'
alias ts='termscp'
alias zj='zellij attach --create principal'
