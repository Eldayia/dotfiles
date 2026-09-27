# ============================================================
# DIRECTORY HELPERS
# ============================================================

mkcd() {

    [[ $# -eq 1 ]] || {
        echo "usage: mkcd <directory>"
        return 1
    }

    mkdir -p -- "$1" &&
        cd -- "$1"
}


# ============================================================
# BACKUPS
# ============================================================

backup() {

    [[ $# -eq 1 ]] || {
        echo "usage: backup <file>"
        return 1
    }

    cp -a -- \
        "$1" \
        "$1.backup-$(date +%Y%m%d-%H%M%S)"
}


# ============================================================
# PYTHON
# ============================================================

venv() {

    python -m venv .venv ||
        return

    source .venv/bin/activate
}


va() {

    if [[ -f .venv/bin/activate ]]; then

        source .venv/bin/activate

    else

        echo ".venv introuvable"
        return 1

    fi
}


# ============================================================
# GIT
# ============================================================

croot() {

    local root

    root="$(git rev-parse --show-toplevel 2>/dev/null)" || {
        echo "Pas dans un dépôt Git."
        return 1
    }

    cd "$root"
}


newrepo() {

    [[ $# -eq 1 ]] || {
        echo "usage: newrepo <name>"
        return 1
    }

    mkdir -p "$1" ||
        return

    cd "$1" ||
        return

    git init
}


gclone() {

    [[ $# -eq 1 ]] || {
        echo "usage: gclone <repository>"
        return 1
    }

    git clone "$1" ||
        return

    local repo="${1:t}"

    repo="${repo%.git}"

    cd "$repo"
}


gitinfo() {

    git status --short --branch

    echo

    git log \
        --oneline \
        --decorate \
        --graph \
        -10
}


# ============================================================
# NETWORK
# ============================================================

serve() {

    python -m http.server "${1:-8000}"
}


killport() {

    [[ $# -eq 1 ]] || {
        echo "usage: killport <port>"
        return 1
    }

    local pid

    pid="$(lsof -ti :"$1")"

    if [[ -z "$pid" ]]; then

        echo "Aucun processus sur le port $1"

        return 1

    fi

    kill "$pid"
}


# ============================================================
# SEARCH
# ============================================================

search() {

    rg \
        --hidden \
        --glob '!.git' \
        "$@"
}


findfile() {

    fd \
        --hidden \
        --exclude .git \
        "$@"
}


# ============================================================
# SCRIPTS
# ============================================================

mkscript() {

    [[ $# -eq 1 ]] || {
        echo "usage: mkscript <name>"
        return 1
    }

    cat > "$1" <<'EOF'
#!/usr/bin/env bash

set -euo pipefail

EOF

    chmod +x "$1"

    "${EDITOR:-nvim}" "$1"
}


# ============================================================
# COMMAND DIAGNOSTICS
# ============================================================

whichall() {

    whence -a "$1"
}

# Yazi: retain the selected working directory on exit.
function y() {
    local tmp cwd result
    tmp="$(mktemp -t yazi-cwd.XXXXXX)" || return
    command yazi "$@" --cwd-file="$tmp"
    result=$?
    cwd="$(command cat -- "$tmp")"
    command rm -f -- "$tmp"
    if [[ -n "$cwd" && "$cwd" != "$PWD" ]]; then
        builtin cd -- "$cwd" || return
    fi
    return "$result"
}

# Obsidian to Site
qsync() {
    rsync -av --delete \
        --exclude='.obsidian/' \
        --exclude='.trash/' \
        "$HOME/Documents/42-Piscine/Public/" \
        "$HOME/Sites/42-notes/content/"
}

qserve() {
    qsync || return 1
    cd "$HOME/Sites/42-notes" || return 1
    npx quartz build --serve
}

qdeploy() {
    qsync || return 1
    cd "$HOME/Sites/42-notes" || return 1
    npx quartz sync
}

function zj() {
    local session="${1:-${PWD:t}}"
    local layout="${2:-}"

    if zellij list-sessions --short 2>/dev/null | grep -Fxq "$session"; then
        zellij attach "$session"
    elif [[ -n "$layout" ]]; then
        zellij --session "$session" --new-session-with-layout "$layout"
    else
        zellij attach -c "$session"
    fi
}
