# Guide GNU Stow pour la gestion des dotfiles

## 📖 Qu'est-ce que GNU Stow ?

GNU Stow est un gestionnaire de liens symboliques qui facilite la gestion des dotfiles. Au lieu de copier vos fichiers de configuration, Stow crée des liens symboliques depuis votre dépôt vers leur emplacement d'utilisation (généralement `~/.config/`).

### Avantages

- ✅ **Versionnement** : Tous vos dotfiles dans un seul dépôt Git
- ✅ **Synchronisation** : Un seul `git pull` pour mettre à jour toutes vos configs
- ✅ **Liens symboliques** : Modifications en temps réel (pas besoin de recopier)
- ✅ **Modularité** : Activation/désactivation sélective de configurations
- ✅ **Portabilité** : Déploiement rapide sur de nouvelles machines

## 🚀 Installation

### Sur NixOS

Stow est déjà installé via `nixos/configuration.nix` :

```nix
environment.systemPackages = with pkgs; [
  stow
  # ...
];
```

### Sur d'autres distributions

```bash
# Debian/Ubuntu
sudo apt install stow

# Arch Linux
sudo pacman -S stow

# Fedora
sudo dnf install stow
```

## 📂 Structure du dépôt pour Stow

Stow considère que votre dépôt est organisé en "packages". Chaque dossier du dépôt représente un package, et sa structure interne reflète l'arborescence cible.

### Exemple de structure

```
dotfiles/
├── .config/
│   ├── hypr/
│   │   └── hyprland.conf
│   ├── nvim/
│   │   └── init.lua
│   └── waybar/
│       └── config
└── nixos/
    └── configuration.nix
```

Avec cette structure, Stow créera :
- `~/.config/hypr/hyprland.conf` → `~/dotfiles/.config/hypr/hyprland.conf`
- `~/.config/nvim/init.lua` → `~/dotfiles/.config/nvim/init.lua`
- etc.

## 🛠️ Commandes essentielles

### Déployer tous les dotfiles

```bash
cd ~/dotfiles
stow -v -t ~/ .
```

**Explication** :
- `-v` : Mode verbose (affiche ce qui est fait)
- `-t ~/` : Target (répertoire cible, ici home)
- `.` : Package à déployer (ici tout le dépôt)

### Déployer un dossier spécifique

Pour déployer uniquement la configuration Hyprland :

```bash
stow -v -t ~/.config/hypr --dir=. --target=~/.config/hypr .config/hypr
```

### Retirer des liens symboliques

```bash
# Tout retirer
stow -D -v -t ~/ .

# Retirer un dossier spécifique
stow -D -v -t ~/.config/hypr .config/hypr
```

**Note** : `-D` signifie "Delete" (supprime les liens symboliques)

### Mettre à jour (re-stow)

```bash
# Retire puis recrée les liens
stow -R -v -t ~/ .
```

**Note** : `-R` signifie "Restow" (équivalent à `-D` puis `-S`)

### Simuler (dry-run)

```bash
# Voir ce qui serait fait sans l'exécuter
stow -n -v -t ~/ .
```

**Note** : `-n` signifie "No execution" (simulation)

## 📋 Workflow complet

### 1. Installation initiale sur une nouvelle machine

```bash
# Cloner le dépôt
cd ~
git clone https://github.com/VOTRE_USERNAME/dotfiles.git
cd dotfiles
git checkout nixos

# Déployer les dotfiles
stow -v -t ~/ .

# Copier la configuration NixOS
sudo cp nixos/configuration.nix /etc/nixos/

# Reconstruire le système
sudo nixos-rebuild switch
```

### 2. Modifier une configuration

```bash
# Éditer directement via le lien symbolique
nvim ~/.config/hypr/hyprland.conf

# OU éditer dans le dépôt (équivalent)
nvim ~/dotfiles/.config/hypr/hyprland.conf

# Versionner les changements
cd ~/dotfiles
git add .config/hypr/hyprland.conf
git commit -m "hypr: ajout de nouveaux raccourcis clavier"
git push
```

### 3. Synchroniser depuis un autre ordinateur

```bash
cd ~/dotfiles
git pull

# Les liens symboliques pointent automatiquement vers les nouveaux fichiers
# Relancer l'application si nécessaire
```

### 4. Ajouter une nouvelle configuration

```bash
cd ~/dotfiles

# Créer la structure
mkdir -p .config/dunst
nvim .config/dunst/dunstrc

# Déployer
stow -R -v -t ~/ .

# Versionner
git add .config/dunst
git commit -m "feat: ajout configuration Dunst"
git push
```

## ⚠️ Gestion des conflits

### Problème : Fichier existant

Si un fichier existe déjà à l'emplacement cible, Stow refusera de créer le lien.

**Solution** :

```bash
# Sauvegarder le fichier existant
mv ~/.config/hypr/hyprland.conf ~/.config/hypr/hyprland.conf.bak

# Puis déployer
stow -v -t ~/ .

# Comparer et fusionner si nécessaire
diff ~/.config/hypr/hyprland.conf ~/.config/hypr/hyprland.conf.bak
```

### Problème : Lien symbolique cassé

Si le lien symbolique pointe vers un fichier qui n'existe plus :

```bash
# Retirer tous les liens
stow -D -v -t ~/ .

# Redéployer
stow -v -t ~/ .
```

## 🎯 Cas d'usage avancés

### Ignorer certains fichiers

Créez un fichier `.stow-local-ignore` à la racine du dépôt :

```bash
# .stow-local-ignore
README\.md
CLAUDE\.md
STOW\.md
\.git
\.gitignore
```

### Déploiement par catégorie

Organisez votre dépôt en packages distincts :

```
dotfiles/
├── hyprland/
│   └── .config/hypr/
├── neovim/
│   └── .config/nvim/
├── shell/
│   └── .config/nushell/
└── terminal/
    └── .config/warp/
```

Puis déployez sélectivement :

```bash
# Déployer uniquement l'environnement graphique
stow -v -t ~/ hyprland

# Déployer l'éditeur
stow -v -t ~/ neovim

# Tout déployer
stow -v -t ~/ */
```

## 🔍 Vérification des liens

### Lister tous les liens symboliques dans ~/.config

```bash
find ~/.config -type l -ls
```

### Vérifier où pointe un lien

```bash
ls -la ~/.config/hypr/hyprland.conf
# Résultat attendu :
# ~/.config/hypr/hyprland.conf -> /home/eldayia/dotfiles/.config/hypr/hyprland.conf
```

### Trouver les liens cassés

```bash
find ~/.config -xtype l
```

## 💡 Bonnes pratiques

1. **Toujours utiliser `-v`** pour voir ce qui se passe
2. **Tester avec `-n`** avant un déploiement sur une nouvelle machine
3. **Versionner régulièrement** vos changements (`git commit`)
4. **Sauvegarder avant d'écraser** les configurations existantes
5. **Documenter** vos configurations (commentaires dans les fichiers)
6. **Utiliser des branches** pour tester de grandes modifications

## 🆘 Dépannage

### Erreur : "Target is not owned by stow"

**Cause** : Un fichier existe déjà à l'emplacement cible.

**Solution** : Déplacer ou supprimer le fichier existant.

### Erreur : "Cannot stow into /"

**Cause** : Tentative de stow à la racine du système.

**Solution** : Toujours spécifier un target avec `-t ~/` ou `-t ~/.config`.

### Stow ne fait rien

**Vérifications** :
1. Êtes-vous dans le bon répertoire ? (`cd ~/dotfiles`)
2. La structure du dépôt est-elle correcte ?
3. Les permissions sont-elles correctes ?

```bash
# Voir ce que Stow ferait
stow -nv -t ~/ .
```

## 📚 Ressources

- [GNU Stow Manual](https://www.gnu.org/software/stow/manual/)
- [Using GNU Stow to manage dotfiles](https://brandon.invergo.net/news/2012-05-26-using-gnu-stow-to-manage-your-dotfiles.html)
- [CLAUDE.md](CLAUDE.md) : Directives pour ce projet
- [README.md](README.md) : Documentation principale

## 🎓 Exemples de commandes courantes

```bash
# Déploiement initial
cd ~/dotfiles && stow -v -t ~/ .

# Mise à jour après git pull
cd ~/dotfiles && git pull && stow -R -v -t ~/ .

# Ajouter une nouvelle config
mkdir -p .config/nouveau && nvim .config/nouveau/config.conf && stow -R -v -t ~/ .

# Retirer temporairement une config
stow -D -v -t ~/.config/dunst .config/dunst

# Tout retirer
stow -D -v -t ~/ .

# Vérifier les liens
find ~/.config -type l | grep dotfiles
```
