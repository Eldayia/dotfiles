# Architecture modulaire du script de téléchargement

## 📁 Structure

```
install/
├── downloadSoftware.bat          # Point d'entrée principal
├── downloadSoftware.bat.old      # Ancien fichier (backup)
├── modules/                      # Modules par catégorie
│   ├── archives.bat              # NanaZip
│   ├── communication.bat         # Discord
│   ├── development.bat           # Git, VSCode, Docker, Python, etc.
│   ├── gaming.bat                # Steam, Epic, GOG, Battle.net, etc.
│   ├── multimedia.bat            # VLC, Mp3tag, Adobe CC, etc.
│   ├── productivity.bat          # 1Password, PowerToys, FileZilla, etc.
│   ├── security.bat              # Bitdefender, NordVPN, Acronis
│   ├── system-tools.bat          # Samsung Magician, Logitech, VMware, etc.
│   └── web.bat                   # Chrome, Chrome Canary
└── common/
    └── functions.bat             # Fonctions réutilisables
```

## 🎯 Avantages

- ✅ **Modularité** : Chaque catégorie dans un fichier séparé
- ✅ **Maintenabilité** : Facile de trouver et modifier un logiciel
- ✅ **Réutilisabilité** : Fonctions communes dans `functions.bat`
- ✅ **Clarté** : Organisation logique par thème
- ✅ **Flexibilité** : Possibilité d'exécuter uniquement certains modules

## 🚀 Utilisation

### Télécharger tous les logiciels

```batch
downloadSoftware.bat
```

### Télécharger une catégorie spécifique

```batch
cd modules
call gaming.bat
```

## ✏️ Modifier les logiciels

### Ajouter un logiciel

1. Ouvrir le module correspondant (ex: `modules\gaming.bat`)
2. Ajouter une ligne :

```batch
REM Mon Nouveau Logiciel
call :DownloadSoftware "Nom" "ID.Winget" "URL_Fallback" "NomFichier.exe"
```

**Exemple :**
```batch
REM Minecraft
call :DownloadSoftware "Minecraft" "Mojang.Minecraft" "https://launcher.mojang.com/download/Minecraft.exe" "MinecraftInstaller.exe"
```

### Supprimer un logiciel

1. Ouvrir le module correspondant
2. Commenter ou supprimer la ligne :

```batch
REM call :DownloadSoftware "Discord" "Discord.Discord" "" ""
```

### Modifier un logiciel

1. Trouver la ligne dans le module
2. Modifier les paramètres :

```batch
REM Avant
call :DownloadSoftware "Discord" "Discord.Discord" "" ""

REM Après (avec URL de fallback)
call :DownloadSoftware "Discord" "Discord.Discord" "https://discord.com/api/download?platform=win" "DiscordSetup.exe"
```

## 🛠️ Fonctions disponibles

### DownloadSoftware

Télécharge via winget, puis fallback vers curl si échec.

```batch
call :DownloadSoftware "Nom" "ID_Winget" "URL_Fallback" "Nom_Fichier"
```

**Paramètres :**
- `Nom` : Nom affiché à l'écran
- `ID_Winget` : ID du paquet winget
- `URL_Fallback` : URL de secours (peut être vide : `""`)
- `Nom_Fichier` : Nom du fichier à télécharger avec curl (peut être vide : `""`)

**Exemple :**
```batch
call :DownloadSoftware "Steam" "Valve.Steam" "" ""
```

### ManualDownloadRequired

Affiche un message pour téléchargement manuel.

```batch
call :ManualDownloadRequired "Nom" "URL"
```

**Exemple :**
```batch
call :ManualDownloadRequired "VMware Workstation" "https://www.vmware.com/"
```

### IncludedWith

Indique qu'un logiciel est inclus avec un autre.

```batch
call :IncludedWith "Nom" "Inclus_Dans"
```

**Exemple :**
```batch
call :IncludedWith "Epic Online Services" "Epic Games Launcher"
```

## 📋 Liste des modules

### archives.bat (1 logiciel)
- NanaZip (manuel)

### communication.bat (1 logiciel)
- Discord

### development.bat (11 logiciels)
- Git, VSCode, Cursor, CMake, Node.js, Python 3.12, Rustup, Docker Desktop, GitKraken, Visual Studio 2022

### gaming.bat (13 logiciels)
- Steam, Epic Games, GOG, Battle.net, EA app, Ubisoft Connect, Amazon Games, Riot Client, Wargaming, HoYoPlay, BlueStacks, CurseForge, Ankama Launcher

### multimedia.bat (5 logiciels)
- VLC, Mp3tag, Apple Music, Adobe Creative Cloud, qBittorrent

### productivity.bat (13 logiciels)
- 1Password, 1Password CLI, PowerToys, Rainmeter, FileZilla, WinSCP, eM Client, TreeSize, UltraSearch, UniGetUI, Warp, UPDF, ReNamer

### security.bat (3 logiciels)
- Bitdefender (manuel), NordVPN, Acronis (manuel)

### system-tools.bat (16 logiciels)
- Samsung Magician, Elgato Stream Deck (manuel), Logi Options+, Logitech G HUB, DisplayLink (manuel), Stardock Start11, Stardock Multiplicity (manuel), TeamViewer, Revo Uninstaller Pro, VMware (manuel), QNAP Qsync (manuel), Raspberry Pi Imager, OrcaSlicer, Comet, LM Studio, Shutter (manuel)

### web.bat (2 logiciels)
- Google Chrome, Google Chrome Canary

## 🔄 Comparaison avec l'ancienne version

### Avant (monolithique)
- ❌ 1 fichier de 401 lignes
- ❌ Difficile à naviguer
- ❌ Modifications risquées
- ❌ Pas de réutilisation de code

### Après (modulaire)
- ✅ 10 fichiers organisés
- ✅ Navigation facile par catégorie
- ✅ Modifications isolées et sûres
- ✅ Fonctions réutilisables
- ✅ Similaire à l'architecture NixOS

## 💡 Conseils

1. **Garder l'ancien fichier** : `downloadSoftware.bat.old` est un backup
2. **Tester module par module** : Exécuter un module individuellement pour tester
3. **Utiliser les commentaires** : Commenter plutôt que supprimer pour garder l'historique
4. **Variables d'environnement** : `%DOWNLOAD_DIR%` est accessible dans tous les modules
5. **Ordre d'exécution** : Les modules sont appelés dans l'ordre défini dans `downloadSoftware.bat`

## 📝 Notes

- Les fonctions sont définies dans `common\functions.bat`
- Chaque module doit appeler `functions.bat` en début de fichier
- Les modules doivent se terminer par `goto :eof` pour retourner au script principal
- La variable `%DOWNLOAD_DIR%` est définie dans le script principal et accessible partout
