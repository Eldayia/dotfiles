{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # ============================================================
    # LANGAGES DE PROGRAMMATION ET OUTILS DE DÉVELOPPEMENT
    # ============================================================

    # --- WEB FRONTEND (HTML, CSS, JavaScript, TypeScript) ---
    nodejs_22                      # Node.js LTS (runtime JavaScript)
    nodePackages.npm               # Gestionnaire de paquets Node
    nodePackages.pnpm              # Alternative rapide à npm
    yarn                           # Gestionnaire de paquets alternatif
    deno                           # Runtime JS/TS moderne et sécurisé
    bun                            # Runtime JS ultra-rapide

    # TypeScript
    nodePackages.typescript        # Compilateur TypeScript
    nodePackages.typescript-language-server  # LSP TypeScript
    nodePackages.ts-node           # Exécution TypeScript directe

    # Linters et Formatters Web
    nodePackages.eslint            # Linter JavaScript/TypeScript
    nodePackages.prettier          # Formateur de code
    nodePackages.stylelint         # Linter CSS/SCSS
    nodePackages.vscode-langservers-extracted  # LSP HTML/CSS/JSON

    # Bundlers et Build Tools
    nodePackages.vite              # Build tool moderne et rapide
    esbuild                        # Bundler ultra-rapide

    # --- VUE.JS ---
    nodePackages."@vue/cli"        # Vue CLI
    nodePackages.vue-language-server  # LSP Vue (Volar)

    # --- PHP ---
    php84                          # PHP 8.4
    php84Packages.composer         # Gestionnaire de dépendances PHP
    php84Extensions.pdo            # Extension PDO
    php84Extensions.pdo_sqlite     # Extension PDO SQLite
    php84Extensions.pdo_mysql      # Extension PDO MySQL
    php84Extensions.mbstring       # Extension multi-byte string
    php84Extensions.curl           # Extension cURL
    php84Extensions.xml            # Extension XML
    php84Extensions.zip            # Extension ZIP
    php84Extensions.gd             # Extension GD (images)

    # --- BASES DE DONNÉES ---
    sqlite                         # SQLite CLI
    sqlitebrowser                  # GUI SQLite
    dbeaver-bin                    # Client universel bases de données

    # --- RUST ---
    rustup                         # Gestionnaire de toolchains Rust
    # rustc, cargo, rustfmt, clippy sont gérés par rustup
    rust-analyzer                  # LSP Rust
    cargo-edit                     # Commandes cargo add/rm/upgrade
    cargo-watch                    # Recompilation automatique
    cargo-audit                    # Audit de sécurité des dépendances
    cargo-expand                   # Expansion des macros

    # --- C / C++ ---
    gcc                            # Compilateur GNU C/C++
    clang                          # Compilateur LLVM C/C++
    cmake                          # Système de build
    gnumake                        # Make
    ninja                          # Build system rapide
    gdb                            # Débogueur GNU
    lldb                           # Débogueur LLVM
    clang-tools                    # clangd, clang-format, clang-tidy
    ccache                         # Cache de compilation
    pkg-config                     # Gestion des flags de compilation
    valgrind                       # Analyse mémoire (Linux only)

    # --- PYTHON ---
    python312                      # Python 3.12
    python312Packages.pip          # Gestionnaire de paquets Python
    python312Packages.virtualenv   # Environnements virtuels
    python312Packages.black        # Formateur de code
    python312Packages.pylint       # Linter Python
    python312Packages.mypy         # Vérification de types statique
    python312Packages.pytest       # Framework de tests
    python312Packages.ipython      # Shell Python interactif
    python312Packages.numpy        # Calcul numérique
    python312Packages.requests     # Requêtes HTTP
    pyright                        # LSP Python (Microsoft)
    uv                             # Gestionnaire de paquets Python ultra-rapide

    # --- JAVA ---
    jdk21                          # Java Development Kit 21 (LTS)
    maven                          # Build tool et gestionnaire de dépendances
    gradle                         # Build tool moderne
    jdt-language-server            # LSP Java (Eclipse)

    # --- KOTLIN ---
    kotlin                         # Compilateur Kotlin
    kotlin-language-server         # LSP Kotlin

    # --- ANDROID ---
    android-studio                 # IDE Android officiel
    android-tools                  # ADB, fastboot, etc.
    # Note: Android SDK est géré par Android Studio

    # --- OUTILS GÉNÉRAUX ---
    # LSP et outils d'édition
    tree-sitter                    # Parser incrémental pour syntax highlighting

    # Contrôle de version (compléments)
    lazygit                        # Interface Git TUI
    delta                          # Diff amélioré pour Git

    # Débogage et profiling
    strace                         # Traçage des appels système
    ltrace                         # Traçage des appels de bibliothèque

    # Containers (pour environnements de dev)
    docker                         # Containers
    docker-compose                 # Orchestration de containers

    # Utilitaires de développement
    just                           # Alternative moderne à make
    hyperfine                      # Benchmarking CLI
    tokei                          # Compteur de lignes de code
    jq                             # Processeur JSON CLI
    yq                             # Processeur YAML CLI
    httpie                         # Client HTTP CLI moderne
    curl                           # Client HTTP/HTTPS classique
    wget                           # Téléchargement de fichiers

    # Documentation
    man-pages                      # Pages man Linux
    man-pages-posix                # Pages man POSIX
  ];

  # --- CONFIGURATION DOCKER ---
  virtualisation.docker = {
    enable = true;
    enableOnBoot = false;  # Démarrage manuel pour économiser les ressources
  };

  # --- VARIABLES D'ENVIRONNEMENT ---
  environment.variables = {
    # Rust
    RUSTUP_HOME = "$HOME/.rustup";
    CARGO_HOME = "$HOME/.cargo";

    # Android
    ANDROID_HOME = "$HOME/Android/Sdk";
    ANDROID_SDK_ROOT = "$HOME/Android/Sdk";
  };

  # --- PATH ADDITIONNEL ---
  environment.sessionVariables = {
    PATH = [
      "$HOME/.cargo/bin"           # Binaires Rust
      "$HOME/.local/bin"           # Binaires utilisateur
      "$HOME/Android/Sdk/platform-tools"  # ADB, fastboot
    ];
  };

  # --- PROGRAMMES AVEC CONFIGURATION SPÉCIALE ---
  programs = {
    # Java
    java = {
      enable = true;
      package = pkgs.jdk21;
    };
  };
}
