# ============================================================
# FZF
# ============================================================

if (( $+commands[fzf] )); then

    export FZF_DEFAULT_OPTS="
        --height=70%
        --layout=reverse
        --border
        --info=inline
        --cycle
    "


    export FZF_CTRL_T_COMMAND="
        fd
            --type f
            --type l
            --hidden
            --follow
            --exclude .git
    "


    export FZF_ALT_C_COMMAND="
        fd
            --type d
            --hidden
            --follow
            --exclude .git
    "


    export FZF_CTRL_T_OPTS="
        --preview '
            bat
                --color=always
                --style=numbers
                --line-range=:300
                {} 2>/dev/null
        '
    "


    export FZF_ALT_C_OPTS="
        --preview '
            eza
                --tree
                --level=2
                --color=always
                --icons=always
                {} 2>/dev/null
        '
    "


    source <(fzf --zsh)

fi


# ============================================================
# ZOXIDE
# ============================================================

if (( $+commands[zoxide] )); then

    eval "$(zoxide init zsh)"

fi


# ============================================================
# ATUIN
# ============================================================

if (( $+commands[atuin] )); then

    eval "$(atuin init zsh --disable-up-arrow)"

fi


# ============================================================
# MISE
# ============================================================

if (( $+commands[mise] )); then

    eval "$(mise activate zsh)"

fi
