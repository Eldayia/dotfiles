@echo off
REM ===============================================
REM Module: Game Development & Audio Production
REM ===============================================

call "%~dp0..\common\functions.bat"

echo.
echo === GAME DEVELOPMENT ^& AUDIO PRODUCTION ===
echo.

REM ===============================================
REM Moteurs de jeu - Généraux
REM ===============================================

REM Godot Engine
call :DownloadSoftware "Godot Engine" "GodotEngine.GodotEngine" "" ""

REM Unity Hub
call :DownloadSoftware "Unity Hub" "Unity.UnityHub" "" ""

REM Ren'Py (visual novels)
call :ManualDownloadRequired "Ren'Py" "https://www.renpy.org/latest.html"

REM ===============================================
REM Outils de narrative design
REM ===============================================

REM Twine (histoires interactives - gratuit)
call :DownloadSoftware "Twine" "ChrisKlimas.Twine" "" ""

REM ===============================================
REM DAW (Digital Audio Workstation)
REM ===============================================

REM Reaper
call :DownloadSoftware "Reaper" "Cockos.REAPER" "https://www.reaper.fm/files/7.x/reaper757_x64-install.exe" "reaper-install.exe"

REM ===============================================
REM Lecteurs de samples (obligatoires)
REM ===============================================

REM Native Access (gestionnaire Native Instruments)
call :DownloadSoftware "Native Access" "NativeInstruments.NativeAccess" "https://www.native-instruments.com/fileadmin/ni_media/downloads/Native-Access_2.exe" "Native-Access.exe"

REM Kontakt 8 (via Native Access après installation)
call :IncludedWith "Kontakt 8" "Native Access (télécharger dans l'app)"

REM Splice (pour Splice Bridge et INSTRUMENT)
call :DownloadSoftware "Splice" "Splice.Splice" "https://splice.com/download" "splice-installer.exe"

REM Splice Bridge (via Splice après installation)
call :IncludedWith "Splice Bridge" "Splice (activer dans l'app)"

REM Splice INSTRUMENT (via Splice après installation)
call :IncludedWith "Splice INSTRUMENT" "Splice (activer dans l'app)"

REM ===============================================
REM Création graphique 2D / Pixel Art
REM ===============================================

REM Aseprite (payant, Steam ou itch.io)
call :ManualDownloadRequired "Aseprite" "https://www.aseprite.org/ (ou compiler depuis GitHub)"

REM Pixelorama (pixel art gratuit, open source)
call :DownloadSoftware "Pixelorama" "OramaInteractive.Pixelorama" "" ""

REM PyxelEdit (pixel art - payant)
call :ManualDownloadRequired "PyxelEdit" "https://pyxeledit.com/"

REM Game Character Hub (payant, Steam)
call :ManualDownloadRequired "Game Character Hub" "https://store.steampowered.com/app/292230/"

REM ===============================================
REM Outils de sprite et textures
REM ===============================================

REM Spriteilluminator (lighting effects - payant)
call :ManualDownloadRequired "Spriteilluminator" "https://www.codeandweb.com/spriteilluminator"

REM PhysicsEditor (collision shapes - payant)
call :ManualDownloadRequired "PhysicsEditor" "https://www.codeandweb.com/physicseditor"

REM TexturepackGUI (texture packing - payant)
call :ManualDownloadRequired "TexturepackGUI" "https://www.codeandweb.com/texturepacker"

REM ===============================================
REM Animation 2D
REM ===============================================

REM Live2D Cubism (animation 2D pour personnages)
call :ManualDownloadRequired "Live2D Cubism" "https://www.live2d.com/en/download/cubism/"

REM Inochi Creator (animation 2D VTuber - open source)
call :ManualDownloadRequired "Inochi Creator" "https://github.com/Inochi2D/inochi-creator/releases/latest"

REM ===============================================
REM Map / Level Design
REM ===============================================

REM Tiled Map Editor
call :DownloadSoftware "Tiled" "mapeditor.Tiled" "" ""

REM Tilesetter (tileset creation - Steam)
call :ManualDownloadRequired "Tilesetter" "https://store.steampowered.com/app/1105890/Tilesetter/"

REM Dungeondraft (map creation - payant)
call :ManualDownloadRequired "Dungeondraft" "https://dungeondraft.net/"

REM Note: Pour les plugins VST et DAW complets, voir le module audioproduction.bat

REM ===============================================
REM Post-installation
REM ===============================================

echo ===============================================
echo CONFIGURATION POST-INSTALLATION GAME DEV
echo ===============================================
echo.
echo 1. NATIVE ACCESS:
echo    - Se connecter avec ton compte Native Instruments
echo    - Télécharger Kontakt 8
echo    - Télécharger les librairies gratuites (Komplete Start)
echo.
echo 2. SPLICE:
echo    - Se connecter avec ton compte Splice
echo    - Activer Splice Bridge dans Preferences
echo    - Télécharger les packs LABS gratuits
echo.
echo 3. REAPER (automatique):
echo    - Lancer Reaper une première fois
echo    - Exécuter le script de configuration:
echo      dotfiles\scripts\gamesdev\Setup-ReaperVST.ps1
echo    - OU si Qsync est synchronisé:
echo      Qsync\GamesDev\_Tools\Reaper\Config\Setup-ReaperVST.ps1
echo    - Puis dans Reaper: Options ^> Preferences ^> VST ^> Re-scan
echo.
echo 4. SYNCHRONISATION QSYNC:
echo    - S'assurer que Qsync synchronise le dossier GamesDev
echo    - Les plugins et samples seront partagés entre les PC
echo.

goto :eof
