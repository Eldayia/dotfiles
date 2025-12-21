# Architecture modulaire du script de téléchargement

## 📁 Structure

```
install/
├── downloadSoftware.bat          # Point d'entrée principal
├── downloadSoftware.bat.old      # Ancien fichier (backup)
├── modules/                      # Modules par catégorie
│   ├── archives.bat              # NanaZip
│   ├── communication.bat         # Vesktop
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
REM call :DownloadSoftware "Vesktop" "Vencord.Vesktop" "" ""
```

### Modifier un logiciel

1. Trouver la ligne dans le module
2. Modifier les paramètres :

```batch
REM Avant
call :DownloadSoftware "Vesktop" "Vencord.Vesktop" "" ""

REM Après (avec URL de fallback)
call :DownloadSoftware "Vesktop" "Vencord.Vesktop" "https://github.com/Vencord/Vesktop/releases/latest" "VesktopSetup.exe"
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
- **NanaZip** (téléchargement manuel)

### communication.bat (1 logiciel)
- **Vesktop** (client Discord alternatif open-source)

### development.bat (24 logiciels)
**Éditeurs de code et IDE (6)**
- Visual Studio Code, Cursor, Android Studio, Visual Studio Community 2026, nano, Neovim
- Visual Studio Installer (inclus avec VS 2026)

**Contrôle de version (2)**
- Git, GitKraken

**Langages de programmation et runtimes (5)**
- OpenJDK 21 (Java), .NET SDK 8 (C#), Python 3.12, Rustup (Rust), Node.js/npm

**Outils de build et compilation C++ (4)**
- CMake, LLVM/Clang, MinGW-w64 (manuel), MSVC Build Tools (inclus avec VS)

**Outils JavaScript/TypeScript (via npm post-installation)**
- TypeScript, Vite, Vue CLI, ESLint, Prettier, Claude Code

**Outils Android (inclus avec Android Studio)**
- Android SDK, Platform Tools, Emulator, Gradle

**Conteneurs et virtualisation (1)**
- Docker Desktop

**Outils IA et assistants (2)**
- Claude Desktop, Claude Code (via npm)

**Création de contenu interactif (1)**
- Twine (téléchargement manuel)

### gaming.bat (13 logiciels - Desktop uniquement)
- Steam, Epic Games Launcher (+ Epic Online Services inclus), GOG GALAXY, Battle.net, EA app, Ubisoft Connect, Amazon Games, Riot Client, Wargaming.net Game Center, HoYoPlay, BlueStacks, CurseForge, Ankama Launcher

### multimedia.bat (5 logiciels)
- VLC media player, Mp3tag, Apple Music, Adobe Creative Cloud, qBittorrent

### productivity.bat (16 logiciels)
- 1Password, 1Password CLI, PowerToys, Rainmeter, FileZilla, WinSCP, eM Client, TreeSize, UltraSearch, UniGetUI, Warp, UPDF, Wondershare Recoverit (manuel), ReNamer, Eagle, Obsidian

### security.bat (4 logiciels)
- Bitdefender Total Security (manuel), NordVPN, Acronis True Image (manuel), Tor Browser

### system-tools.bat (17 logiciels)
**Périphériques et pilotes (6)**
- Samsung Magician (Desktop uniquement), Elgato Stream Deck (manuel, Desktop uniquement), Logi Options+ (Desktop uniquement), Logitech G HUB (Desktop uniquement), DisplayLink Graphics (manuel, Desktop uniquement), Epson ET-2710 Drivers (manuel)

**Personnalisation et utilitaires (4)**
- Stardock Start11, Stardock Multiplicity (manuel), TeamViewer, Revo Uninstaller Pro (tous les PC)

**Virtualisation et réseau (2)**
- VMware Workstation (manuel), QNAP Qsync Client (manuel)

**Matériel et outils spécialisés (2)**
- Raspberry Pi Imager, OrcaSlicer

**Divers (3)**
- Comet, LM Studio, Shutter (manuel)

### web.bat (2 logiciels)
- Google Chrome, Google Chrome Canary

---

**TOTAL : 83 logiciels** (sans compter les outils npm et les logiciels inclus)

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

## 🔧 Post-installation

### Outils npm pour développement JavaScript/TypeScript

Après l'installation de Node.js via le module `development.bat`, installer les outils de développement globaux :

```batch
npm install -g typescript
npm install -g vite
npm install -g @vue/cli
npm install -g eslint
npm install -g prettier
npm install -g @anthropic-ai/claude-code
```

Ces outils fournissent :
- **TypeScript** : Typage statique pour JavaScript
- **Vite** : Build tool ultra-rapide pour applications modernes
- **Vue CLI** : Scaffold et gestion de projets Vue.js
- **ESLint** : Linter pour maintenir la qualité du code
- **Prettier** : Formateur de code automatique
- **Claude Code** : CLI de Claude pour assistance IA au développement

## 💡 Conseils

1. **Garder l'ancien fichier** : `downloadSoftware.bat.old` est un backup
2. **Tester module par module** : Exécuter un module individuellement pour tester
3. **Utiliser les commentaires** : Commenter plutôt que supprimer pour garder l'historique
4. **Variables d'environnement** : `%DOWNLOAD_DIR%` est accessible dans tous les modules
5. **Ordre d'exécution** : Les modules sont appelés dans l'ordre défini dans `downloadSoftware.bat`
6. **Post-installation npm** : Ne pas oublier d'installer les outils npm après Node.js
7. **Desktop vs Laptop** : Le script principal demande le type de PC pour adapter l'installation

## 📝 Notes

- Les fonctions sont définies dans `common\functions.bat`
- Chaque module doit appeler `functions.bat` en début de fichier
- Les modules doivent se terminer par `goto :eof` pour retourner au script principal
- La variable `%DOWNLOAD_DIR%` est définie dans le script principal et accessible partout
