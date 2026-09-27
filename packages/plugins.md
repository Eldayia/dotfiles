# Plugins gérés hors Pacman/AUR

## Neovim — lazy.nvim

Configuration : `nvim/.config/nvim/lua/plugins/workflow.lua`.
Versions exactes : `nvim/.config/nvim/lazy-lock.json`.

| Plugin | Fonction |
| --- | --- |
| mfussenegger/nvim-dap | Débogage C/C++/Rust avec lldb-dap |
| rcarriga/nvim-dap-ui | Interface du débogueur |
| nvim-neotest/nvim-nio | Dépendance asynchrone DAP UI/Neotest |
| stevearc/conform.nvim | Formatage manuel avec Ruff, StyLua et shfmt |
| stevearc/overseer.nvim | Tâches de compilation et commandes |
| nvim-neotest/neotest | Interface des tests |
| nvim-neotest/neotest-python | Adaptateur Python/pytest |

Installation des plugins manquants et hooks du dépôt :

```bash
bash ~/dotfiles/scripts/setup-dev-tools.sh
```

Pour restaurer les révisions verrouillées : `:Lazy restore` dans Neovim.
Les dépendances système sont dans pacman.txt, notamment lldb, stylua et python-pytest.

## DMS

| Identifiant | Plugin |
| --- | --- |
| dankKDEConnect | Phone Connect |
| intelGpuMonitor | Intel GPU Monitor |
| commandRunner | Command Runner |

Révisions : `dms/.config/DankMaterialShell/plugins.lock.json`.
Préférences portables : `plugin-defaults.json`, dans le même dossier.
Sources et historiques locaux exclus de Git ; la configuration DMS est liée par Stow.

```bash
bash ~/dotfiles/scripts/setup-dms-plugins.sh
```

Le script restaure les versions verrouillées, applique les préférences et recharge
DMS si une session est active. Phone Connect et Intel GPU Monitor sont ajoutés à
la première barre active. Command Runner utilise Ghostty et le préfixe `>`.
Le fichier local `plugin_settings.json` conserve les appareils associés et
l’historique des commandes ; il n’est pas versionné.

Après une mise à jour volontaire des plugins :

```bash
dms plugins lock
```

Relire le diff du lockfile avant de l’enregistrer.
