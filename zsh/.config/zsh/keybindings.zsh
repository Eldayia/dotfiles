# ============================================================
# KEYBINDINGS
# ============================================================

bindkey -e


# ============================================================
# HISTORY SUBSTRING SEARCH
# ============================================================

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

bindkey '^[OA' history-substring-search-up
bindkey '^[OB' history-substring-search-down


# ============================================================
# NAVIGATION
# ============================================================

bindkey '^[[1;5D' backward-word
bindkey '^[[1;5C' forward-word


# Home
bindkey '^[[H' beginning-of-line
bindkey '^[[1~' beginning-of-line


# End
bindkey '^[[F' end-of-line
bindkey '^[[4~' end-of-line


# Delete
bindkey '^[[3~' delete-char


# ============================================================
# EMACS SHORTCUTS
# ============================================================

bindkey '^A' beginning-of-line

bindkey '^E' end-of-line

bindkey '^U' backward-kill-line

bindkey '^K' kill-line

bindkey '^W' backward-kill-word

bindkey '^P' up-history

bindkey '^N' down-history


# ============================================================
# AUTOSUGGESTIONS
# ============================================================

bindkey '^ ' autosuggest-accept
