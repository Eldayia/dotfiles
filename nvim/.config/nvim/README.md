# Neovim 42 - configuration complète

## Installation

Sauvegarde l'ancienne config :

```bash
mv ~/.config/nvim ~/.config/nvim.backup
```

Copie ce dossier :

```bash
mkdir -p ~/.config
cp -r nvim-42-complete ~/.config/nvim
```

Puis lance :

```bash
nvim
```

## Dépendances

Vérifie :

```bash
git --version
make --version
rg --version
python3 --version
zsh --version
norminette --version
c_formatter_42 --help
```

Si nécessaire :

```bash
python3 -m pip install --user -U norminette c-formatter-42
```

Dans `~/.zshrc` :

```bash
export PATH="$HOME/.local/bin:$PATH"
export USER42="ton_login"
export MAIL42="ton_login@student.42.fr"
```

Puis :

```bash
source ~/.zshrc
```

## 42

- `F1` : header 42
- `F2` : `c_formatter_42` sur le fichier courant
- `F3` : Norminette sur le fichier courant
- `Space n` : Norminette sur tous les `.c` et `.h` du projet, récursivement

## Explorer

- `Space e` : afficher/masquer Neo-tree
- `l` / `Enter` : ouvrir ou développer
- `h` : replier
- `v` : ouvrir en split vertical
- `s` : ouvrir en split horizontal

Neo-tree s'ouvre automatiquement avec `nvim` ou `nvim .`.

## Terminal

- `Ctrl+\` : terminal horizontal en bas
- `Space tt` : idem
- zsh est utilisé automatiquement s'il existe
- `Esc Esc` : mode normal du terminal
- `Ctrl+h/j/k/l` : naviguer entre les fenêtres, y compris depuis le terminal

## Telescope

- `Space ff` : fichiers
- `Space fg` : recherche dans le projet
- `Space fb` : buffers
- `Space fr` : fichiers récents
- `Space fh` : aide
- `Space /` : recherche dans le buffer courant

## clangd / LSP

- `K` : documentation
- `gd` : définition
- `gD` : déclaration
- `gi` : implémentation
- `gT` : définition de type
- `gr` : références
- `Space ss` : symboles du fichier
- `Space sS` : symboles du projet
- `Space cr` : renommer
- `Space ca` : code action
- `Space cd` : diagnostic
- `]d` / `[d` : diagnostic suivant/précédent
- `Ctrl+k` en insertion : signature

## blink.cmp

- `Ctrl+n` : suggestion suivante
- `Ctrl+p` : suggestion précédente
- `Tab` / `Shift+Tab` : naviguer
- `Enter` : accepter
- `Ctrl+Space` : ouvrir la complétion
- `Ctrl+e` : fermer

## UI

- `Space rn` : numéros relatifs
- `Space tl` : caractères invisibles
- `Space xx` : diagnostics
- `Shift+l` / `Shift+h` : buffer suivant/précédent

## Lazy.nvim

`Not Loaded` dans `:Lazy` est normal pour un plugin chargé à la demande.

Vérifications utiles :

```vim
:Lazy
:Mason
:LspInfo
:checkhealth
:checkhealth vim.lsp
```
