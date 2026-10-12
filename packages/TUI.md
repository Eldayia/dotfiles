# Outils terminal et WireGuard

Paquets officiels listés dans pacman.txt.
Les thèmes sont Catppuccin Mocha, avec opacité Ghostty à 90 %.

## Déploiement

```sh
bash ~/dotfiles/scripts/stow-configs.sh
```

## Utilisation

Ouvrir un nouveau terminal pour charger les fonctions et alias Zsh.

| Commande | Application | Raccourci Niri |
| --- | --- | --- |
| `bt` | Btop | Mod+Shift+B |
| `y` | Yazi, conserve le dossier choisi | Mod+Shift+Y |
| `zj` | Zellij, session principal | Mod+Shift+Z |
| `ld` | Lazydocker | Mod+Shift+D |
| `ts` | TermSCP | Mod+Shift+S |

Docker est activé via docker.service. Le groupe docker est déjà configuré.
Les raccourcis sont dans niri/.config/niri/custom/tui.kdl.

## Outils CLI

Paquets officiels, sauf topgrade-bin et viddy-bin (AUR). Configs Stow : bat, git (delta),
mise, navi, pueue, starship, tealdeer, television, topgrade.

| Commande / raccourci | Outil | Rôle |
| --- | --- | --- |
| prompt | Starship | Remplace Powerlevel10k, palette Catppuccin Mocha |
| `git diff`, `git log -p` | delta | Pager Git, thème catppuccin-mocha (thème git/.config/git/themes) |
| `cat`, aperçus fzf | bat | Thème Catppuccin Mocha ; après changement : `bat cache --build` |
| `tldr` | tealdeer | Pages fr puis en, mises à jour hebdomadaires |
| Alt+T, `tv` | television | Finder par canaux ; Ctrl+T reste à fzf, Ctrl+R à Atuin |
| Ctrl+G, `navi` | navi | Aide-mémoire ; cheats perso dans navi/.config/navi/cheats |
| `mise use node@22` | mise | Versions d’outils par projet (mise.toml) |
| `sd 'avant' 'après' f` | sd | Remplacement de texte |
| `cx` / `dx` / `lx` | ouch | Compresser / décompresser / lister une archive |
| `mdr fichier.md` | glow | Lecture Markdown (`md` reste `mkdir -p`) |
| `hex` | hexyl | Vue hexadécimale |
| `fx fichier.json` | fx | Explorateur JSON |
| `j` | just | Tâches de projet (justfile) |
| `watchexec -e c make` | watchexec | Relance à chaque modification |
| `trip hôte` | trippy | Traceroute + ping (sudo) |
| `gping hôte` | gping | Ping graphique |
| `bw` | bandwhich | Débit réseau par processus (sudo) |
| `watch` | viddy | `watch` avec historique et diff |
| `pq` | pueue | File de tâches ; démon pueued.service (utilisateur) |
| `up` | topgrade | Mise à jour globale (paru, flatpak, omz, Lazy.nvim, dépôt dotfiles) |

## WireGuard avec NetworkManager

wireguard-tools est installé. Aucun tunnel n’est créé sans profil client réel.
Conserver les clés et profils VPN hors du dépôt ; ne pas les gérer avec Stow.
Le fichier client doit contenir les sous-réseaux réels des serveurs dans AllowedIPs.

Pour importer un profil existant, remplacer le chemin ci-dessous :

```sh
chmod 600 /chemin/serveurs.conf
sudo nmcli connection import type wireguard file /chemin/serveurs.conf
```

Utiliser ensuite le nom affiché par l’import à la place de serveurs :

```sh
sudo nmcli connection modify serveurs connection.autoconnect no wireguard.peer-routes yes ipv4.never-default yes ipv6.never-default yes
sudo nmcli connection up serveurs
sudo wg show
# Vérifier la route vers une adresse réelle de serveur :
ip route get IP_DU_SERVEUR
# Déconnexion :
sudo nmcli connection down serveurs
```

Aucun service wg-quick ni fournisseur resolvconf n’est nécessaire ici.
Les directives PostUp/PostDown ne sont pas reproduites par cet import.

## Sources des thèmes

- Btop : https://github.com/catppuccin/btop
- Yazi : https://github.com/yazi-rs/flavors/tree/main/catppuccin-mocha.yazi
- bat : https://github.com/catppuccin/bat
- delta : https://github.com/catppuccin/delta
- Starship : https://github.com/catppuccin/starship
- TermSCP : https://github.com/veeso/termscp/blob/main/themes/catppuccin-moka.toml
- Format TermSCP : https://docs.termscp.rs/en-US/configuration/themes.html

Le thème Yazi est intégré directement à theme.toml ; aucun téléchargement au lancement.
Seul theme.toml est lié pour TermSCP ; les favoris et identifiants restent locaux.
