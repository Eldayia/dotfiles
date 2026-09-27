# Command Center DMS

Copilot fonctionne avec **Super+Shift+F23** sur ce clavier (confirmé par l’utilisateur). Les variantes XF86Assistant et F24 restent prises en charge, ainsi que Super+Maj+Espace. Les bindings sont dans `niri/.config/niri/custom/command-center.kdl`.

Le lanceur DMS remplace Walker pour ces raccourcis. Il affiche les sept applications favorites en grille, les autres applications, et la recherche en bas. Le mode Tous inclut applications, fichiers, dossiers et plugins. Le plugin Command Runner existant accepte `> commande` ; l’onglet Fichiers restreint la recherche aux fichiers. Deux caractères sont nécessaires pour la recherche globale de fichiers.

## Sources de configuration

- `dms/.config/DankMaterialShell/command-center-defaults.json` : favoris et réglages reproductibles.
- `dms/.config/DankMaterialShell/settings.json` : réglages DMS actifs.
- `dms/.config/DankMaterialShell/themes/catppuccin-mocha.json` : palette partagée par DMS, transparence des fenêtres à 82 %.
- `dms/patches/command-center-v1.6.2.patch` : ajout de la section favoris et déplacement de la recherche. Les fonctions de recherche et les actions natives restent celles de DMS.
- `command-center/.config/danksearch/config.toml` : index local du dossier personnel, sans dossiers cachés et avec exclusions des dépendances/builds.
- `command-center/.config/systemd/user/dsearch.service` : service d’indexation local par socket Unix.

Les favoris sont appliqués à `~/.local/state/DankMaterialShell/session.json` sans versionner l’historique ni les autres données de session. Pour les modifier, éditer `command-center-defaults.json`, puis lancer `python ~/dotfiles/scripts/apply-command-center.py`. L’application conserve les autres favoris déjà épinglés.

## Réinstallation

```sh
~/dotfiles/scripts/setup-command-center.sh
```

Aucun sudo nécessaire si DMS, Python, curl/HTTPS, patch et Stow sont disponibles. Le script récupère les sources officielles DMS 1.6.2 et leur module partagé, vérifie leurs SHA-256, applique le petit patch et installe l’interface dans `~/.local/share/dms-command-center/quickshell`. Il installe aussi le binaire officiel dsearch 1.6.0 dans `~/.local/bin` après vérification SHA-256.

Le script refuse une autre version de DMS : adapter le patch avant une mise à jour du shell. `DMS_SHELL_DIR` est défini pour Niri, systemd et les prochaines sessions. Depuis un ancien terminal, utiliser `export DMS_SHELL_DIR="$HOME/.local/share/dms-command-center/quickshell"` pour les commandes `dms ipc`.

Les anciens fichiers Walker/Elephant restent disponibles, mais ils ne pilotent plus Copilot. keyd n’est pas nécessaire à Copilot ; son remappage facultatif de Super gauche continue d’utiliser F24.

## Diagnostic et retour à l’interface officielle

`systemctl --user status dms dsearch`, `~/.local/bin/dsearch search README --json`, `niri validate`.

Pour revenir à l’interface officielle, retirer le complément systemd `dms.service.d/command-center.conf`, la variable DMS_SHELL_DIR dans Niri et dans `environment/.config/environment.d/60-command-center.conf`, puis `systemctl --user unset-environment DMS_SHELL_DIR`, `systemctl --user daemon-reload` et `systemctl --user restart dms`. Relancer la session pour nettoyer les environnements hérités.
