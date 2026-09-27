# Système, développement et bureau

Les logiciels sont déclarés dans [pacman.txt](pacman.txt). Aucun paquet AUR n’a
été ajouté pour cette sélection. Les plugins sont recensés dans [plugins.md](plugins.md).

## Reproduire la configuration

Après l’installation des paquets :

```bash
cd ~/dotfiles
bash scripts/stow-configs.sh
bash scripts/setup-nautilus.sh
bash scripts/setup-dms-plugins.sh
bash scripts/setup-dev-tools.sh
# Sur une racine Btrfs :
sudo bash scripts/setup-snapper.sh
sudo systemctl enable --now smartd.service
```

setup-user.sh appelle aussi les scripts Nautilus, DMS et développement.
Les réglages utilisateur sont liés avec Stow. La politique Snapper est conservée
sous `system/snapper/` et appliquée par l’outil officiel avec des droits root :
/etc ne dépend pas d’un lien vers un dépôt utilisateur ni de la disponibilité de /home.

## Instantanés et santé des disques

- Snapper gère une configuration `root` pour `/`.
- snap-pac crée automatiquement une paire avant/après les transactions Pacman.
- Rétention : 12 instantanés ordinaires, 4 importants ; âge minimal d’une heure.
- Le timer snapper-cleanup applique le nettoyage. Aucun instantané horaire n’est activé.
- Btrfs Assistant permet d’inspecter les instantanés et sous-volumes.
- smartd surveille les disques détectés ; consulter ses événements avec
  `journalctl -u smartd`. Aucun envoi de courriel n’est configuré.

Sur cette machine, `/home`, `/var/log`, le cache Pacman et `/boot` sont séparés
et ne font pas partie des instantanés racine. Les snapshots restent sur le même
SSD : Pika Backup conserve son rôle de sauvegarde externe. Aucun menu de démarrage
sur snapshot ni restauration automatique n’a été configuré. En cas de restauration,
il faut notamment assurer la cohérence entre `/boot` et les modules du noyau.

```bash
sudo snapper -c root list
sudo snapper -c root create --description "Avant modification" --cleanup-algorithm number
systemctl status snapper-cleanup.timer smartd.service
sudo smartctl -H /dev/nvme0n1
sudo nvme smart-log /dev/nvme0
```

Adapter les chemins de périphérique sur une autre machine. GNOME Firmware fournit
une interface à fwupd ; aucune mise à jour de firmware n’est lancée par les scripts.

## Neovim

| Raccourci | Action |
| --- | --- |
| F5 | Lancer/continuer le débogage ; choisir un exécutable compilé avec `-g` |
| F9 | Ajouter/retirer un point d’arrêt |
| F10 / F11 / F12 | Passer / entrer / sortir d’une fonction |
| Espace d u / Espace d q | Interface DAP / arrêt du débogage |
| Espace l f | Formatage manuel Conform : Python, Lua, shell |
| Espace o r / Espace o t | Lancer une tâche Overseer / afficher les tâches |
| Espace u t / Espace u f | Test le plus proche / tests du fichier |
| Espace u s / Espace u o | Résumé des tests / sortie d’un test |

F1/F2/F3 et Norminette restent inchangés pour C/42. Conform ne formate pas
automatiquement à l’enregistrement et n’emploie pas clang-format sur ces fichiers.
DAP est préparé pour C/C++/Rust avec LLDB ; il ne compile pas le programme lui-même.
Pour un programme C isolé : `cc -g -O0 main.c -o programme`.
Neotest est configuré avec l’adaptateur Python/pytest ; installer pytest dans le
virtualenv du projet s’il en utilise un. Les projets C avec Make restent accessibles
via Overseer ; aucun adaptateur de tests C spécifique n’est présumé.

## Outils de développement

- pre-commit installe les hooks de ce dépôt : Gitleaks sur les changements indexés
  et Ruff sur les fichiers Python. Aucun commit n’est créé automatiquement.
- `git dft` active Difftastic pour une comparaison ponctuelle ; Git Delta reste en place.
- `xh`, `dbeaver`, `mtr`, `rclone`, `sshfs` et `trivy` sont disponibles.
- Les connexions DBeaver, identifiants rclone, montages SSHFS et profils de serveur
  restent à renseigner selon les besoins ; aucun secret n’est ajouté au dépôt.
- Trivy peut télécharger sa base de vulnérabilités à sa première analyse.

## Audio, images et jeux

EasyEffects est installé avec les effets LSP. Aucun traitement audio ni démarrage
automatique n’est imposé : ouvrir l’application et sélectionner les effets adaptés
au casque/micro. Sa base locale de périphériques reste hors du dépôt.
Loupe, Calculatrice GNOME, Éditeur de texte GNOME et wev sont disponibles.
Les associations de fichiers existantes sont conservées.

GOverlay dispose d’une configuration MangoHud Mocha dans
`mangohud/.config/MangoHud/MangoHud.conf`, liée avec Stow.
Pour l’activer dans un jeu Steam, ajouter `mangohud %command%` à ses options de lancement.
L’overlay n’est pas imposé à toutes les applications. Protontricks est installé avec
Yad pour son interface graphique. `intel_gpu_top` permet un diagnostic Intel plus
approfondi et peut nécessiter des droits supplémentaires selon les compteurs.

## Vérifications

```bash
cd ~/dotfiles
python -m pytest -q tests/test_nautilus_actions.py
pre-commit validate-config
niri validate
```

Les tests Nautilus couvrent les noms complexes, les URI, les sélections invalides,
les archives sans écrasement, les symlinks, la conversion WebP et SHA-256.
