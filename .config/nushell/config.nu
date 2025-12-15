# --- CONFIGURATION NUSHELL ---
# Configuration principale de Nushell

# --- OPTIONS GÉNÉRALES ---
$env.config = {
    show_banner: false  # Masquer la bannière au démarrage

    # Comportement du shell
    shell_integration: {
        osc2: true
        osc7: true
        osc8: true
        osc9_9: false
        osc133: true
        osc633: true
        reset_application_mode: true
    }

    # Édition de ligne
    edit_mode: vi  # Mode vi pour l'édition (ou emacs)

    # Historique
    history: {
        max_size: 100000
        sync_on_enter: true
        file_format: "sqlite"
        isolation: false
    }

    # Completion
    completions: {
        case_sensitive: false
        quick: true
        partial: true
        algorithm: "fuzzy"
        external: {
            enable: true
            max_results: 100
            completer: null
        }
    }

    # Keybindings
    keybindings: [
        {
            name: completion_menu
            modifier: none
            keycode: tab
            mode: [emacs vi_normal vi_insert]
            event: {
                until: [
                    { send: menu name: completion_menu }
                    { send: menunext }
                    { edit: complete }
                ]
            }
        }
    ]

    # Curseur
    cursor_shape: {
        emacs: line
        vi_insert: line
        vi_normal: block
    }

    # Couleurs
    # color_config: $dark_theme  # Variable non définie - utiliser le thème par défaut
    use_grid_icons: true
    footer_mode: 25
    float_precision: 2
    buffer_editor: "nvim"

    # Hooks
    hooks: {
        pre_prompt: [{ null }]
        pre_execution: [{ null }]
        env_change: {
            PWD: [{|before, after| null }]
        }
        display_output: "if (term size).columns >= 100 { table -e } else { table }"
        command_not_found: { null }
    }
}

# --- THÈME SOMBRE ---
let dark_theme = {
    separator: white
    leading_trailing_space_bg: { attr: n }
    header: green_bold
    empty: blue
    bool: white
    int: white
    filesize: cyan
    duration: white
    date: purple
    range: white
    float: white
    string: white
    nothing: white
    binary: white
    cell-path: white
    row_index: green_bold
    record: white
    list: white
    block: white
    hints: dark_gray
}

# --- ALIAS ---
# Navigation
alias ll = ls -l
alias la = ls -a
alias lla = ls -la

# Git
alias gs = git status
alias ga = git add
alias gc = git commit
alias gp = git push
alias gl = git log --oneline --graph --decorate
alias gd = git diff

# Système
alias c = clear
alias .. = cd ..
alias ... = cd ../..

# Modern replacements
alias cat = bat
alias find = fd
alias grep = rg
alias top = btop

# Yazi file manager avec CD support
alias y = yazi

# --- STARSHIP PROMPT ---
# Activer Starship comme prompt
$env.STARSHIP_SHELL = "nu"

def create_left_prompt [] {
    starship prompt --cmd-duration $env.CMD_DURATION_MS --status $env.LAST_EXIT_CODE --jobs $nu.os-info.jobid
}

def create_right_prompt [] {
    ""
}

$env.PROMPT_COMMAND = { || create_left_prompt }
$env.PROMPT_COMMAND_RIGHT = { || create_right_prompt }
$env.PROMPT_INDICATOR = ""
$env.PROMPT_INDICATOR_VI_INSERT = ": "
$env.PROMPT_INDICATOR_VI_NORMAL = "〉"
$env.PROMPT_MULTILINE_INDICATOR = "::: "

# --- INTÉGRATIONS EXTERNES ---
# Zoxide (CD intelligent)
zoxide init nushell | save -f ~/.zoxide.nu
source ~/.zoxide.nu

# Atuin (Historique amélioré)
# source ~/.atuin/bin/env.nu
# atuin init nu | save -f ~/.atuin.nu
# source ~/.atuin.nu

# Direnv (Chargement automatique d'environnements)
# direnv hook nushell | save -f ~/.config/direnv/hook.nu
# source ~/.config/direnv/hook.nu

# --- FONCTIONS CUSTOM ---
# Fonction pour extraire des archives
def extract [file: string] {
    match ($file | path parse | get extension) {
        "tar" => { tar -xf $file }
        "gz" => {
            if ($file | str ends-with ".tar.gz") {
                tar -xzf $file
            } else {
                gunzip $file
            }
        }
        "zip" => { unzip $file }
        "7z" => { 7z x $file }
        _ => { echo "Format non supporté" }
    }
}

# Fonction pour créer et entrer dans un répertoire
def mkcd [dir: string] {
    mkdir $dir
    cd $dir
}

# Fonction pour envoyer du contenu vers Hastebin
# Usage: command | haste
# Exemple: cat file.log | haste
def haste [] {
    let content = $in
    let hastebin_url = "https://paste.eldadev.fr"

    # Envoyer le contenu à Hastebin
    let response = (
        http post
            --content-type "text/plain"
            $"($hastebin_url)/documents"
            $content
    )

    # Extraire la clé du document
    let key = ($response | get key)

    # Construire et afficher l'URL complète
    let url = $"($hastebin_url)/($key)"
    print $"✓ Paste créé: ($url)"

    # Copier l'URL dans le clipboard si wl-copy est disponible
    if (which wl-copy | is-not-empty) {
        $url | wl-copy
        print "✓ URL copiée dans le presse-papier"
    }

    # Retourner l'URL
    $url
}

# Alias pour haste
alias paste = haste

# Fonction pour afficher les informations système au démarrage
# fastfetch
