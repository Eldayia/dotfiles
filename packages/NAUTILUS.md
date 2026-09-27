# Nautilus enrichi

## Installé

| Paquet | Utilisation |
| --- | --- |
| ghostty-nautilus | Clic droit → Open in Ghostty, dans le dossier courant ou sélectionné |
| sushi | Sélectionner un fichier puis Espace pour l’aperçu |
| nautilus-image-converter | Clic droit sur les images : redimensionner et pivoter |
| file-roller | Gestionnaire graphique d’archives |
| nautilus-admin-gtk4 (AUR) | Ouvrir un dossier via admin:// avec authentification |
| rabbitvcs + rabbitvcs-nautilus (AUR) | Actions Git/Subversion, état des fichiers, différences via Meld |

Ghostty fournit son extension officielle dans les dépôts Arch. Elle transmet le
répertoire et désactive le mode instance unique uniquement pour cette ouverture.
Il n’est donc pas nécessaire de changer la configuration globale Ghostty ni
d’installer nautilus-open-any-terminal en doublon.

L’extension gtkhash-nautilus n’est pas disponible dans les dépôts interrogés.
L’action « Calculer SHA-256 » couvre le calcul des sommes de contrôle :
clic droit sur les fichiers locaux → Scripts → Calculer SHA-256.
Le résultat s’affiche dans Ghostty, sans modifier les fichiers.

Nautilus Admin utilise le backend GVfs admin://. L’édition d’un fichier dépend
de la prise en charge de cette URI par son application par défaut ; le bloc-notes
DMS actuellement associé aux fichiers texte n’a pas été validé pour ce mode.

## Configuration reproductible

```sh
bash ~/dotfiles/scripts/setup-nautilus.sh
```

Ce script déploie le paquet Stow nautilus et applique :

- dossiers en premier ;
- action « Créer un lien » disponible ;
- Meld comme outil de différences RabbitVCS.

setup-user.sh l’appelle aussi. Les réglages GSettings ne se déploient pas par
simple lien symbolique : apply-settings.sh les applique au profil utilisateur.
Les historiques et données de connexion RabbitVCS restent hors du dépôt.

Fermer les fenêtres Nautilus et le relancer après la fin des copies en cours.
Si le processus reste actif : `nautilus -q`, puis relancer Fichiers.

## Actions et applications supplémentaires installées

Dans clic droit → Scripts :

- **Comparer avec Meld** : sélectionner exactement deux fichiers ou deux dossiers.
- **Copier les chemins absolus** : chemins séparés par des retours à la ligne dans
  le presse-papiers Wayland.
- **Ouvrir dans Lazygit** : sélectionner un dossier appartenant à un dépôt Git ;
  sans sélection, le dossier courant est utilisé.
- **Calculer SHA-256** : calculer les empreintes des fichiers sélectionnés.
- **Ouvrir dans Neovim** : fichiers sélectionnés, ou dossier courant, dans Ghostty.
- **Informations du fichier** : type, taille, droits, dates et métadonnées MediaInfo ;
  taille occupée pour un dossier.
- **Créer une archive datée** : une archive `.tar.gz` des éléments sélectionnés,
  dans leur dossier parent commun. Les liens symboliques sont conservés comme liens.
- **Convertir en WebP** : nouvelles images datées, qualité 85 ; première page/image
  uniquement pour les images animées ou multipages. Originaux conservés.
- **Vérifier SHA-256** : sélectionner un fichier et coller l’empreinte attendue
  dans la boîte de dialogue. Le résultat de comparaison est affiché.

Les opérations longues affichent leur progression ou leur résultat dans Ghostty.
Archives et conversions refusent d’écraser un fichier existant. Appuyer sur Entrée
pour fermer le terminal une fois l’opération terminée.

Ces scripts opèrent sur des fichiers locaux. Leurs arguments ne sont pas évalués
par un shell. Ils sont déployés avec Stow ; leur code commun est dans
nautilus/.config/nautilus/actions.py.

**Collision** est installé depuis les dépôts officiels : lancer Collision depuis
le menu d’applications pour générer, comparer et vérifier les empreintes.
Son extension Nautilus est également installée ; rouvrir Nautilus pour la charger.
https://apps.gnome.org/Collision/

**Pika Backup** est installé depuis les dépôts officiels : lancer Sauvegardes Pika
pour créer une première sauvegarde. Aucun dépôt ni horaire n’est activé ; il faut
choisir une destination locale ou un serveur et les paramètres de chiffrement.
Les profils de sauvegarde et identifiants restent locaux, hors du dépôt dotfiles.
https://apps.gnome.org/PikaBackup/

KDE Connect dispose déjà d’une extension Nautilus installée : utile pour envoyer
un fichier à un appareil déjà associé.

## Sources

- https://archlinux.org/packages/extra/x86_64/ghostty-nautilus/
- https://aur.archlinux.org/packages/nautilus-admin-gtk4
- https://github.com/rabbitvcs/rabbitvcs
- https://github.com/gtkhash/gtkhash

Les recettes AUR ont été examinées et compilées localement dans
~/.cache/nautilus-build. Les dépendances AUR python-pysvn et python-pycxx figurent
aussi dans packages/aur.txt pour rendre l’installation explicite.
