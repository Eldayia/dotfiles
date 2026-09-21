# Paquets installés explicitement

- `pacman.txt` : paquets présents dans les dépôts configurés (`pacman -Qqen`).
- `aur.txt` : paquets hors de ces dépôts (`pacman -Qqem`), y compris les éventuels paquets locaux et de débogage. Leur présence ici ne garantit pas leur disponibilité dans l’AUR.

Les dépendances ne sont pas listées : le gestionnaire de paquets les résout à l’installation.

Pour actualiser les listes :

```sh
pacman -Qqen | LC_ALL=C sort -u > packages/pacman.txt
pacman -Qqem | LC_ALL=C sort -u > packages/aur.txt
```

Pour déployer toutes les configurations du dépôt, avec vérification préalable des conflits :

```sh
bash scripts/stow-configs.sh
```

Les profils de navigateur, sessions, caches, clés et identifiants restent hors des paquets Stow ajoutés.
