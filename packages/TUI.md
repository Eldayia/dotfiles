# Outils terminal et WireGuard

Paquets officiels listés dans pacman.txt ; aucun paquet AUR supplémentaire.
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
- TermSCP : https://github.com/veeso/termscp/blob/main/themes/catppuccin-moka.toml
- Format TermSCP : https://docs.termscp.rs/en-US/configuration/themes.html

Le thème Yazi est intégré directement à theme.toml ; aucun téléchargement au lancement.
Seul theme.toml est lié pour TermSCP ; les favoris et identifiants restent locaux.
