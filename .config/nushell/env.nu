# --- VARIABLES D'ENVIRONNEMENT NUSHELL ---
# Configuration des chemins et variables d'environnement

# --- PATH ---
# Ajouter des répertoires au PATH
$env.PATH = ($env.PATH | split row (char esep) | prepend [
    $"($env.HOME)/.local/bin"
    $"($env.HOME)/.cargo/bin"
    "/usr/local/bin"
])

# --- ÉDITEUR ---
$env.EDITOR = "nvim"
$env.VISUAL = "nvim"

# --- VARIABLES HYPRLAND / WAYLAND ---
$env.XDG_SESSION_TYPE = "wayland"
$env.XDG_CURRENT_DESKTOP = "Hyprland"
$env.QT_QPA_PLATFORM = "wayland"
$env.WLR_NO_HARDWARE_CURSORS = "1"  # Pour les VMs

# --- VARIABLES TERMINAL ---
$env.TERM = "xterm-256color"

# --- FZF (Fuzzy Finder) ---
$env.FZF_DEFAULT_COMMAND = "fd --type f --hidden --follow --exclude .git"
$env.FZF_DEFAULT_OPTS = "--height 40% --layout=reverse --border --inline-info"
$env.FZF_CTRL_T_COMMAND = "$FZF_DEFAULT_COMMAND"

# --- BAT (Cat avec coloration) ---
$env.BAT_THEME = "TwoDark"
$env.BAT_STYLE = "numbers,changes,header"

# --- RIPGREP ---
$env.RIPGREP_CONFIG_PATH = $"($env.HOME)/.config/ripgrep/config"

# --- LESS ---
$env.LESS = "-R"
$env.LESSHISTFILE = "-"

# --- LS_COLORS (pour eza/ls) ---
# Généré avec vivid si installé: vivid generate molokai
# $env.LS_COLORS = (vivid generate molokai)

# --- ZOXIDE ---
$env.ZOXIDE_CMD_OVERRIDE = "cd"

# --- VARIABLES LOCALES ---
$env.LANG = "fr_FR.UTF-8"
$env.LC_ALL = "fr_FR.UTF-8"

# --- NIX ---
# Si vous utilisez Nix en mode utilisateur
# $env.NIX_PATH = $"nixpkgs=($env.HOME)/.nix-defexpr/channels/nixpkgs"

# --- DÉVELOPPEMENT ---
# Node.js
# $env.NODE_ENV = "development"

# Python
# $env.PYTHONDONTWRITEBYTECODE = "1"

# Go
# $env.GOPATH = $"($env.HOME)/go"
# $env.PATH = ($env.PATH | prepend $"($env.GOPATH)/bin")

# Rust
# $env.CARGO_HOME = $"($env.HOME)/.cargo"

# --- XDG BASE DIRECTORIES ---
$env.XDG_CONFIG_HOME = $"($env.HOME)/.config"
$env.XDG_DATA_HOME = $"($env.HOME)/.local/share"
$env.XDG_CACHE_HOME = $"($env.HOME)/.cache"
$env.XDG_STATE_HOME = $"($env.HOME)/.local/state"

# --- HISTORIQUE ---
# La configuration de l'historique se fait dans config.nu
# mais on peut définir le chemin ici si nécessaire
# $env.HISTORY_FILE = $"($env.XDG_DATA_HOME)/nushell/history.txt"

# --- STARSHIP ---
# Starship est initialisé dans config.nu
# Mais on peut définir un fichier de config custom ici
# $env.STARSHIP_CONFIG = $"($env.XDG_CONFIG_HOME)/starship.toml"
