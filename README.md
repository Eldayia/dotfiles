<div align="center">

# ✦ Dotfiles

**Un environnement Arch Linux, du premier terminal au bureau.**

`Arch Linux` · `Niri-Spicy` · `DankMaterialShell` · `Ghostty` · `Zsh` · `Catppuccin`

Configurations personnelles, logiciels et scripts de mise en place,
réunis dans un dépôt et déployés avec **GNU Stow**.

[Installation](#-installer-son-environnement) · [Scripts](#-les-scripts-du-dépôt) · [Stow](#-utiliser-stow-au-quotidien) · [Dépannage](#-dépannage)

</div>

---

## 🧭 Le principe

Le dépôt contient les fichiers de référence. **Stow crée des liens symboliques dans ton dossier personnel** pour que les applications les utilisent directement.

```text
~/dotfiles/ghostty/.config/ghostty/config
                     ▲
                     │ lien symbolique
                     │
             ~/.config/ghostty/config
```

Modifier le fichier depuis `~/.config` ou depuis le dépôt revient donc à modifier la même configuration. Git conserve l’historique ; Stow s’occupe de son emplacement.

> **Garde le dépôt à un emplacement stable**, idéalement `~/dotfiles`. Le déplacer ou le supprimer casserait les liens des applications.

### Ce que tu retrouves ici

| Ensemble | Contenu |
| :--- | :--- |
| **Bureau** | Niri-Spicy, effets de flou, DankMaterialShell, écran de connexion greetd/DMS |
| **Terminal** | Ghostty, Zsh, Oh My Zsh, Powerlevel10k, complétions et raccourcis |
| **Apparence** | Catppuccin, GTK, Qt, Kvantum, Cava et Fastfetch |
| **Développement** | Git, Neovim, VS Code, CLion, Lazygit, GitFourchette et Lazydocker |
| **Fichiers** | Nautilus et ses scripts, Yazi, TermSCP, aperçus et archives |
| **Système** | Listes Pacman/AUR et scripts d’installation |

## 🚀 Installer son environnement

### 1 · Préparer Arch Linux

Ces scripts commencent **après l’installation du système de base et son premier démarrage**. Ils ne partitionnent pas le disque et ne configurent pas le chargeur d’amorçage, le chiffrement, les locales ou le fuseau horaire.

Pendant l’installation d’Arch, prépare :

- un système amorçable avec une connexion réseau fonctionnelle ;
- un utilisateur normal disposant de `sudo` ;
- des miroirs Pacman et les dépôts adaptés à la machine.

Le [guide d’installation Arch](https://wiki.archlinux.org/title/Installation_guide) couvre cette première partie.

**Connecte-toi ensuite avec ton utilisateur**, dans un TTY ou une session existante. Ne lance pas les scripts depuis l’ISO, dans `arch-chroot`, ni avec `sudo bash` : ils utilisent `$HOME` pour placer les configurations et appellent eux-mêmes `sudo` lorsque nécessaire.

Installe les outils de départ :

```bash
sudo pacman -Syu --needed git base-devel stow
```

### 2 · Récupérer et personnaliser le dépôt

```bash
git clone https://github.com/Eldayia/dotfiles.git "$HOME/dotfiles"
cd "$HOME/dotfiles"
```

Si le dépôt est privé, authentifie-toi auprès de GitHub. Avec une clé SSH déjà configurée, tu peux utiliser `git@github.com:Eldayia/dotfiles.git` à la place de l’URL HTTPS.

**Avant d’installer la liste complète, adapte ces fichiers :**

| Fichier | À vérifier |
| :--- | :--- |
| [packages/pacman.txt](packages/pacman.txt) | Logiciels souhaités, noyaux, pilotes et paquets propres au matériel |
| [packages/aur.txt](packages/aur.txt) | Logiciels AUR souhaités et disponibilité des noms |
| [git/.config/git/config](git/.config/git/config) | Ton nom et ton adresse Git |
| [niri/.config/niri/dms/outputs.kdl](niri/.config/niri/dms/outputs.kdl) | Noms des écrans, résolution et positionnement |
| [desktop/.config/user-dirs.dirs](desktop/.config/user-dirs.dirs) | Noms et chemins des dossiers personnels |

Cette sélection correspond à une machine **Intel** et contient notamment Steam et des bibliothèques 32 bits. Active `[multilib]` dans `/etc/pacman.conf` si tu conserves ces paquets, puis effectue une mise à jour complète avec `sudo pacman -Syu`.

`pacman.txt` inclut aussi des paquets issus des dépôts configurés sur la machine d’origine : **cela ne signifie pas qu’ils sont tous disponibles sur une installation Arch vierge**. Par exemple, `chatgpt-bin` provient ici d’un dépôt supplémentaire. Configure le dépôt correspondant selon ses instructions, ou retire la ligne si tu ne souhaites pas ce logiciel. Les scripts ne configurent pas ces dépôts pour toi.

Les noms comme `paru-debug` ou `yay-debug` peuvent correspondre à des sous-paquets produits pendant une compilation. Retire-les de la liste de réinstallation s’ils ne sont pas disponibles individuellement ; ne cherche pas à forcer leur installation.

> **Niri-Spicy fait partie de cette configuration.** Le fichier `custom/effects.kdl` utilise ses effets de flou. Remplacer simplement le paquet par Niri standard peut rendre la configuration invalide.

### 3 · Installer les paquets et services

Depuis `~/dotfiles` :

```bash
bash scripts/install-system.sh
```

Le script :

1. vérifie que le système est Arch et que l’utilisateur n’est pas root ;
2. lance `sudo pacman -Syu`, puis installe les paquets de `pacman.txt` ;
3. compile et installe `paru` s’il est absent ;
4. installe `niri-spicy-git` et vérifie qu’il fournit la dépendance `niri` ;
5. installe `dms-shell-niri`, puis le reste de `aur.txt` ;
6. active et démarre NetworkManager, Bluetooth, `power-profiles-daemon`, smartd et Ollama ;
7. installe le remappage keyd de Super gauche (`system/etc/keyd`) et active keyd ;
8. active `fstrim.timer` pour les démarrages suivants et crée les dossiers XDG.

DMS est volontairement installé après Niri-Spicy. Si la vérification du fournisseur `niri` échoue, le script s’arrête avant d’installer DMS.

Lis les transactions et les recettes proposées par l’outil AUR. Les scripts s’arrêtent sur une erreur : corrige la cause avant de les relancer. `--needed` évite de réinstaller les paquets déjà à jour, mais ce parcours n’est pas une transaction globale avec annulation automatique.

### 4 · Préparer les liens Stow

Avant l’initialisation de la session, déploie les configurations du dépôt :

```bash
bash scripts/stow-configs.sh
```

Le script fait **une simulation complète**, puis applique les liens uniquement si elle réussit. Sur une nouvelle installation, des fichiers créés par le shell ou `xdg-user-dirs-update` peuvent déjà occuper les chemins attendus.

Si Stow signale un conflit, suis la procédure [Résoudre un conflit](#résoudre-un-conflit). Relance ensuite cette étape jusqu’à ce que la simulation passe.

Cette étape permet notamment à `setup-user.sh` de trouver la configuration Niri existante et d’éviter qu’une génération DMS préalable crée des fichiers concurrents.

### 5 · Initialiser la session utilisateur

```bash
bash scripts/setup-user.sh
```

Le script prépare les dossiers utilisateur, installe **Oh My Zsh**, **Powerlevel10k** et **fzf-tab**, puis déploie les configurations avec Stow. Il définit Zsh comme shell par défaut si nécessaire.

Il traite aussi :

- Rust stable, uniquement si `rustup` est déjà installé et sans toolchain active ;
- la base `pkgfile`, si l’outil est disponible ;
- les plugins Neovim/DMS verrouillés, les widgets et les hooks pre-commit du dépôt ;
- les extensions VS Code et le plugin Catppuccin de CLion ;
- l’initialisation DMS/Niri, en conservant la configuration Niri déjà présente ;
- les scripts et préférences Nautilus via `setup-nautilus.sh` ;
- l’association du service utilisateur DMS à Niri ;
- l’activation des services utilisateur Open WebUI, Elephant et Syncthing ;
- l’ajout de l’utilisateur au groupe `docker`, si ce groupe existe ;
- la validation de Zsh et de Niri.

Lance cette étape depuis une vraie connexion utilisateur pour disposer du gestionnaire de services utilisateur et de D-Bus. **Déconnecte-toi puis reconnecte-toi** pour appliquer le shell, les variables de session et l’appartenance aux groupes. `exec zsh` recharge seulement le shell courant.

### 6 · Tester Niri avant l’écran de connexion

Depuis un TTY, hors d’une autre session graphique :

```bash
niri validate
niri-session -l
```

Vérifie le clavier, les écrans, Ghostty et DMS. Une fois la session testée, tu peux configurer l’écran de connexion :

```bash
cd "$HOME/dotfiles"
bash scripts/setup-greeter.sh
```

Ce script demande si Niri fonctionne : répondre **`y`** pour continuer. Il exécute `dms-greeter enable`, synchronise les réglages avec `dms-greeter sync`, puis active `greetd.service` au démarrage.

Si un autre gestionnaire de connexion est déjà activé, désactive-le avant de passer à greetd. Le script ne choisit pas à ta place lequel remplacer. Redémarre ensuite lorsque tu es prêt.

### 7 · Terminer les intégrations personnelles

Pour préparer les instantanés de la racine Btrfs :

```bash
sudo bash "$HOME/dotfiles/scripts/setup-snapper.sh"
```

La politique est versionnée sous `system/snapper/`. Le script conserve `/etc`
indépendant du dossier personnel ; les configurations utilisateur utilisent Stow.
Consulte [les limites et la rétention](packages/EXTENSIONS.md) avant une restauration.


| Fonction | Étape restante sur une nouvelle machine |
| :--- | :--- |
| **Docker / Lazydocker** | Si souhaité : `sudo systemctl enable --now docker.service`, puis vérifier `docker info` après reconnexion. Le script utilisateur configure le groupe, mais ne démarre pas Docker. Le groupe Docker donne un accès équivalent à root. |
| **WireGuard** | Importer un vrai profil client dans NetworkManager ; voir [TUI.md](packages/TUI.md). |
| **Pika Backup** | Choisir une destination, le chiffrement et éventuellement une planification dans l’application. |
| **Comptes et SSH** | Configurer tes accès Git, tes clés SSH et tes connexions applicatives localement. |
| **Nautilus** | Après les copies en cours, quitter avec `nautilus -q`, puis rouvrir Fichiers pour charger les extensions. |

## 🛠 Les scripts du dépôt

Tous les exemples se lancent avec **Bash**, même lorsque ton shell habituel est Zsh.

| Script | Quand l’utiliser | Action principale |
| :--- | :--- | :--- |
| [install-system.sh](scripts/install-system.sh) | Après le premier démarrage d’Arch | Paquets Pacman/AUR et services système |
| [stow-configs.sh](scripts/stow-configs.sh) | Avant l’initialisation, puis après ajout de configurations | Simulation et déploiement de tous les paquets Stow détectés |
| [setup-user.sh](scripts/setup-user.sh) | Initialisation de l’utilisateur | Shell, DMS, liens, Nautilus et validations |
| [setup-greeter.sh](scripts/setup-greeter.sh) | Une fois Niri testé | Écran de connexion greetd/DMS |
| [setup-nautilus.sh](scripts/setup-nautilus.sh) | Installation ou modification des actions Nautilus | Stow du paquet Nautilus, puis application des préférences |
| [import-dms.sh](scripts/import-dms.sh) | Import ponctuel d’une configuration DMS locale | Déplacement dans le dépôt, puis lien Stow |
| [setup-snapper.sh](scripts/setup-snapper.sh) | Après installation de Snapper, avec sudo | Instantanés racine Btrfs et rétention |
| [setup-dms-plugins.sh](scripts/setup-dms-plugins.sh) | Restaurer Phone Connect, Intel GPU Monitor et Command Runner | Versions verrouillées, préférences et widgets DMS |
| [setup-dev-tools.sh](scripts/setup-dev-tools.sh) | Initialiser le dépôt et Neovim | Hooks pre-commit et plugins Neovim manquants |
| [setup-ides.sh](scripts/setup-ides.sh) | Restaurer VS Code et CLion | Extensions, plugin Catppuccin et configurations Stow |

### Importer une configuration DMS existante

Le parcours normal déploie déjà la configuration DMS du dépôt. `import-dms.sh` sert à importer une configuration que tu as créée localement à la place.

Il déplace `~/.config/DankMaterialShell` vers `dms/.config/DankMaterialShell`, puis lance Stow. Il ne fait pas de fusion et ne sauvegarde pas automatiquement la destination.

**Utilise-le uniquement si le dossier local existe, n’est pas un lien et que la destination dans le dépôt n’existe pas.** Si elle existe déjà, compare et sauvegarde les deux versions avant de choisir celle à conserver. Ne lance pas ce script pour actualiser un dossier déjà géré par Stow : il n’y a rien à importer.

```bash
bash scripts/import-dms.sh
```

## 🔗 Utiliser Stow au quotidien

### Déployer toutes les configurations

```bash
cd "$HOME/dotfiles"
bash scripts/stow-configs.sh
```

Le script détecte les dossiers contenant `.config`, `.bashrc` ou `.zshrc`. Les dossiers `scripts` et `packages` ne sont pas déployés dans `$HOME`.

Il crée les liens ; **il n’installe aucun logiciel** et n’applique pas lui-même les préférences GSettings. Pour Nautilus, utilise aussi :

```bash
bash scripts/setup-nautilus.sh
```

### Déployer un seul paquet

```bash
cd "$HOME/dotfiles"

# Prévisualiser les changements
stow --target="$HOME" --simulate --restow ghostty

# Appliquer
stow --target="$HOME" --restow ghostty
```

`--restow` recalcule les liens d’un paquet déjà déployé. Ajouter `--no-folding` permet de créer des liens fichier par fichier plutôt que de lier un dossier complet ; cette option est utilisée par le script Nautilus.

### Retirer les liens d’un paquet

```bash
cd "$HOME/dotfiles"
stow --target="$HOME" --simulate --delete ghostty
stow --target="$HOME" --delete ghostty
```

Les fichiers du dépôt restent en place. Cela ne désinstalle pas Ghostty et ne restaure pas les réglages qui existaient avant Stow.

### Résoudre un conflit

Un conflit signifie généralement qu’un vrai fichier existe déjà à l’endroit où Stow souhaite créer un lien. **Compare les versions, puis déplace uniquement le fichier ou dossier concerné dans une sauvegarde.**

Exemple pour une configuration Ghostty locale que tu as choisi de remplacer par celle du dépôt :

```bash
# Vérifier les chemins et comparer avant tout déplacement
ls -ld "$HOME/.config/ghostty"
diff -ru "$HOME/.config/ghostty" "$HOME/dotfiles/ghostty/.config/ghostty"

# Seulement si ~/.config/ghostty est un dossier local, pas un lien Stow
backup_dir="$HOME/.local/state/dotfiles-backups/$(date +%Y%m%d-%H%M%S)"
mkdir -p "$backup_dir"
mv "$HOME/.config/ghostty" "$backup_dir/ghostty"

cd "$HOME/dotfiles"
stow --target="$HOME" --restow ghostty
```

Applique le même principe aux chemins exacts signalés, par exemple `.zshrc` ou `.config/user-dirs.dirs`. Évite de déplacer tout `~/.config` : il contient aussi les données d’autres applications.

`stow --adopt` importe les fichiers locaux dans le dépôt et peut remplacer tes versions de référence. Ce n’est donc pas le raccourci à utiliser pour simplement faire disparaître un conflit.

### Ajouter une nouvelle application

Reproduis son chemin relatif à `$HOME` dans un nouveau paquet :

```text
dotfiles/
└── mon-app/
    └── .config/
        └── mon-app/
            └── config.toml
```

Place ta configuration dans ce dossier, sauvegarde toute version locale concurrente, puis :

```bash
cd "$HOME/dotfiles"
stow --target="$HOME" --simulate mon-app
stow --target="$HOME" mon-app
```

Ajoute également le logiciel à `packages/pacman.txt` ou `packages/aur.txt`, selon sa provenance. Pour un paquet contenant uniquement `.local`, le script global ne le détectera pas automatiquement : déploie-le explicitement ou adapte sa détection.

## 📦 Entretenir les listes de paquets

Les listes décrivent un environnement personnel complet. Elles peuvent évoluer indépendamment des configurations Stow.

Pour reconstruire un inventaire depuis la machine actuelle, **depuis le dépôt** :

```bash
cd "$HOME/dotfiles"
pacman -Qqen | LC_ALL=C sort -u > packages/pacman.txt
pacman -Qqem | LC_ALL=C sort -u > packages/aur.txt
git diff -- packages/
```

Ces commandes remplacent les listes par les paquets installés explicitement. Elles peuvent donc retirer des paquets que tu avais prévus mais pas encore installés. La seconde liste contient les paquets étrangers aux dépôts configurés, pas nécessairement uniquement des paquets disponibles dans l’AUR.

Relis notamment les paquets `-debug`, les paquets locaux et les changements de dépôt avant de conserver cet inventaire. Voir aussi [packages/README.md](packages/README.md).

## 🌿 Modifier et synchroniser son environnement

```bash
cd "$HOME/dotfiles"
git status --short
git diff
```

Après modification d’une configuration, recharge l’application concernée. Un lien existant voit immédiatement le contenu modifié ; relance Stow surtout pour les nouveaux fichiers ou les changements d’arborescence.

Pour récupérer une mise à jour, une fois tes modifications locales examinées et enregistrées :

```bash
git pull --ff-only
bash scripts/stow-configs.sh
bash scripts/setup-nautilus.sh
niri validate
zsh -n "$HOME/.zshrc"
```

Si les listes de logiciels ont changé, examine leur différence avant de relancer l’installation système. Un `git pull` n’installe pas les nouveaux paquets.

Ne versionne pas les clés SSH/WireGuard, profils VPN privés, mots de passe, sessions ou profils de sauvegarde. Le `.gitignore` fournit quelques exclusions, mais ne remplace pas une relecture de `git diff --cached` avant un commit.

## 🩺 Dépannage

| Symptôme | Vérification ou action |
| :--- | :--- |
| `target not found` pendant l’installation | Vérifier les dépôts, `[multilib]` et le nom du paquet dans les listes. |
| Stow refuse de créer un lien | Suivre [Résoudre un conflit](#résoudre-un-conflit), puis relancer la simulation. |
| DMS génère une configuration concurrente | Déployer d’abord les configurations Niri/Ghostty du dépôt avec Stow. |
| `niri validate` échoue sur les effets | Vérifier `niri --version`, Niri-Spicy et les fichiers inclus dans `custom/`. |
| `Failed to connect to bus` | Relancer depuis une vraie session de l’utilisateur, hors root/chroot. |
| Les groupes ou variables ne changent pas | Fermer complètement la session et se reconnecter. |
| Lazydocker ne joint pas Docker | Vérifier `systemctl status docker` et `id -nG`, puis l’activation du service. |
| Les extensions Nautilus n’apparaissent pas | Quitter Nautilus après les copies en cours, puis rouvrir Fichiers. |
| Un script échoue à mi-parcours | Lire la première erreur ; les étapes précédentes peuvent déjà avoir été appliquées. |

## 📚 Aller plus loin

- [Outils terminal, raccourcis et WireGuard](packages/TUI.md)
- [Nautilus, extensions et scripts de fichiers](packages/NAUTILUS.md)
- [Inventaire des paquets](packages/README.md)
- [Configuration Neovim](nvim/.config/nvim/README.md)
- [Système, développement, audio et jeux](packages/EXTENSIONS.md)
- [Inventaire des plugins Neovim et DMS](packages/plugins.md)

---

<div align="center">

**Installer les paquets → déployer les liens → initialiser la session → personnaliser.**

</div>

## Command Center

[Command Center : installation, raccourcis et configuration](packages/COMMAND-CENTER.md)
