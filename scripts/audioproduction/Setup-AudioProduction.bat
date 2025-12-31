@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion

REM ===============================================
REM Script d'installation Audio Production
REM Reaper + MiniLab 3 + Plugins VST
REM ===============================================

echo.
echo ╔══════════════════════════════════════════════════════════════════╗
echo ║     🎹 SETUP AUDIO PRODUCTION - Reaper + MiniLab 3 🎹            ║
echo ╚══════════════════════════════════════════════════════════════════╝
echo.

REM ===============================================
REM Configuration des chemins
REM ===============================================

set "DOWNLOAD_DIR=%USERPROFILE%\Downloads\AudioSetup"
set "VST_DIR=%USERPROFILE%\Qsync\GamesDev\_Library\DAW\Plugins"
set "INSTALLERS_DIR=%DOWNLOAD_DIR%\Installers"
set "ARCHIVES_DIR=%DOWNLOAD_DIR%\VST-Archives"
set "CHECKLIST_FILE=%DOWNLOAD_DIR%\CHECKLIST-Installation.md"

echo Dossier telechargements: %DOWNLOAD_DIR%
echo Dossier plugins VST:     %VST_DIR%
echo.

REM ===============================================
REM Création des dossiers
REM ===============================================

echo [1/6] Creation des dossiers...

if not exist "%DOWNLOAD_DIR%" mkdir "%DOWNLOAD_DIR%"
if not exist "%INSTALLERS_DIR%" mkdir "%INSTALLERS_DIR%"
if not exist "%ARCHIVES_DIR%" mkdir "%ARCHIVES_DIR%"
if not exist "%VST_DIR%\VST" mkdir "%VST_DIR%\VST"
if not exist "%VST_DIR%\VST3" mkdir "%VST_DIR%\VST3"
if not exist "%VST_DIR%\CLAP" mkdir "%VST_DIR%\CLAP"

echo   ^> Dossiers crees avec succes
echo.

REM ===============================================
REM Téléchargements directs (curl)
REM ===============================================

echo [2/6] Telechargement des plugins (liens directs)...
echo.

REM Dexed (Yamaha DX7 emulation)
if not exist "%ARCHIVES_DIR%\dexed-windows.zip" (
    echo   Telechargement de Dexed...
    curl -L -o "%ARCHIVES_DIR%\dexed-windows.zip" "https://github.com/asb2m10/dexed/releases/download/v0.9.7/dexed-0.9.7-windows.zip" 2>nul
    if exist "%ARCHIVES_DIR%\dexed-windows.zip" (
        echo   ^> Dexed telecharge
    ) else (
        echo   ^> Echec - telecharger manuellement
    )
) else (
    echo   ^> Dexed deja telecharge
)

REM Sitala (Drum machine)
if not exist "%INSTALLERS_DIR%\Sitala-Installer-Win64.exe" (
    echo   Telechargement de Sitala...
    curl -L -o "%INSTALLERS_DIR%\Sitala-Installer-Win64.exe" "https://decomposer.de/sitala/Sitala-Installer-Win64.exe" 2>nul
    if exist "%INSTALLERS_DIR%\Sitala-Installer-Win64.exe" (
        echo   ^> Sitala telecharge
    ) else (
        echo   ^> Echec - telecharger manuellement
    )
) else (
    echo   ^> Sitala deja telecharge
)

REM OTT (Xfer compression)
if not exist "%ARCHIVES_DIR%\OTT_Win.zip" (
    echo   Telechargement de OTT...
    curl -L -o "%ARCHIVES_DIR%\OTT_Win.zip" "https://xferrecords.com/product_downloads/47/OTT_Win_v121.zip" 2>nul
    if exist "%ARCHIVES_DIR%\OTT_Win.zip" (
        echo   ^> OTT telecharge
    ) else (
        echo   ^> Echec - telecharger manuellement
    )
) else (
    echo   ^> OTT deja telecharge
)

echo.

REM ===============================================
REM Ouverture des pages web par catégorie
REM ===============================================

echo [3/6] Ouverture des pages de telechargement...
echo.

echo --- MINILAB 3 ^& ARTURIA ---
echo   - MIDI Control Center: https://www.arturia.com/support/downloads^&manuals
echo   - Analog Lab Intro: Inclus avec MiniLab 3 (enregistrer sur arturia.com)
echo.
set /p OPEN_ARTURIA="  Ouvrir les pages Arturia ? (O/n): "
if /i not "%OPEN_ARTURIA%"=="n" (
    start "" "https://www.arturia.com/support/downloads&manuals"
    timeout /t 1 >nul
    start "" "https://www.arturia.com/login"
)

echo.
echo --- GESTIONNAIRES DE PLUGINS ---
echo   - Native Access: https://www.native-instruments.com/en/specials/native-access-2/
echo   - Spitfire Audio App: https://www.spitfireaudio.com/info/library-manager
echo.
set /p OPEN_MANAGERS="  Ouvrir les pages gestionnaires ? (O/n): "
if /i not "%OPEN_MANAGERS%"=="n" (
    start "" "https://www.native-instruments.com/en/specials/native-access-2/"
    timeout /t 1 >nul
    start "" "https://www.spitfireaudio.com/info/library-manager"
)

echo.
echo --- REAPER PLUGINS ---
echo   - ReaLearn (Helgobox): https://github.com/helgoboss/helgobox/releases/latest
echo.
set /p OPEN_REAPER="  Ouvrir la page ReaLearn ? (O/n): "
if /i not "%OPEN_REAPER%"=="n" (
    start "" "https://github.com/helgoboss/helgobox/releases/latest"
)

echo.
echo --- SYNTHETISEURS ---
echo   - Vital: https://vital.audio/
echo   - Dexed: Deja telecharge (ou https://github.com/asb2m10/dexed/releases)
echo   - Magical 8bit Plug: http://www.ymck.net/en/download/magical8bitplug/
echo.
set /p OPEN_SYNTHS="  Ouvrir les pages synthetiseurs ? (O/n): "
if /i not "%OPEN_SYNTHS%"=="n" (
    start "" "https://vital.audio/"
    timeout /t 1 >nul
    start "" "http://www.ymck.net/en/download/magical8bitplug/"
)

echo.
echo --- INSTRUMENTS ^& DRUMS ---
echo   - Spitfire LABS: https://labs.spitfireaudio.com/
echo   - Komplete Start: Via Native Access
echo   - MT Power Drum Kit: https://www.powerdrumkit.com/
echo.
set /p OPEN_INSTRUMENTS="  Ouvrir les pages instruments ? (O/n): "
if /i not "%OPEN_INSTRUMENTS%"=="n" (
    start "" "https://labs.spitfireaudio.com/"
    timeout /t 1 >nul
    start "" "https://www.powerdrumkit.com/"
)

echo.
echo --- EFFETS ---
echo   - Valhalla Supermassive: https://valhalladsp.com/shop/reverb/valhalla-supermassive/
echo   - TDR Nova: https://www.tokyodawn.net/tdr-nova/
echo   - OTT: Deja telecharge
echo.
set /p OPEN_EFFECTS="  Ouvrir les pages effets ? (O/n): "
if /i not "%OPEN_EFFECTS%"=="n" (
    start "" "https://valhalladsp.com/shop/reverb/valhalla-supermassive/"
    timeout /t 1 >nul
    start "" "https://www.tokyodawn.net/tdr-nova/"
)

echo.

REM ===============================================
REM Génération de la checklist Markdown
REM ===============================================

echo [4/6] Generation de la checklist...

(
echo # 🎹 Checklist Installation Audio Production
echo.
echo **Genere le:** %DATE% %TIME%
echo **Dossier telechargements:** %DOWNLOAD_DIR%
echo **Dossier VST:** %VST_DIR%
echo.
echo ---
echo.
echo ## ✅ Etape 1 : MiniLab 3 ^& Arturia
echo.
echo - [ ] **Enregistrer le MiniLab 3** sur [arturia.com](https://www.arturia.com/login^)
echo   - Creer un compte si necessaire
echo   - Enregistrer le numero de serie du clavier
echo.
echo - [ ] **MIDI Control Center** - Telecharger et installer
echo   - [Page telechargement](https://www.arturia.com/support/downloads^)
echo.
echo - [ ] **Analog Lab Intro** - Installer via Arturia Software Center
echo   - Disponible apres enregistrement du MiniLab 3
echo.
echo - [ ] **UVI Model D** - Recuperer le code et installer
echo   - Code fourni avec le MiniLab 3
echo.
echo - [ ] **Native Instruments The Gentleman** - Recuperer le code
echo   - Code fourni avec le MiniLab 3
echo   - Installer via Native Access
echo.
echo ---
echo.
echo ## ✅ Etape 2 : Gestionnaires de plugins
echo.
echo - [ ] **Native Access** - [Telecharger](https://www.native-instruments.com/en/specials/native-access-2/^)
echo   - Creer compte Native Instruments
echo   - Installer The Gentleman ^(code MiniLab^)
echo   - Installer Komplete Start ^(gratuit^)
echo.
echo - [ ] **Spitfire Audio App** - [Telecharger](https://www.spitfireaudio.com/info/library-manager^)
echo   - Creer compte Spitfire Audio
echo   - Installer LABS ^(65 packs gratuits^)
echo.
echo ---
echo.
echo ## ✅ Etape 3 : Configuration Reaper
echo.
echo - [ ] **ReaLearn** - [GitHub Releases](https://github.com/helgoboss/helgobox/releases/latest^)
echo   - Telecharger `helgobox-windows-x64.msi`
echo   - Installer ^(inclut ReaLearn^)
echo   - Redemarrer Reaper
echo.
echo - [ ] **Configurer les chemins VST dans Reaper**
echo   ```
echo   Options ^> Preferences ^> Plug-ins ^> VST
echo   Ajouter:
echo   - %VST_DIR%\VST
echo   - %VST_DIR%\VST3
echo   - %VST_DIR%\CLAP
echo   ```
echo.
echo - [ ] **Re-scanner les plugins**
echo   - Options ^> Preferences ^> Plug-ins ^> VST ^> Re-scan
echo.
echo ---
echo.
echo ## ✅ Etape 4 : Synthetiseurs
echo.
echo - [ ] **Vital** - [vital.audio](https://vital.audio/^)
echo   - Creer compte gratuit
echo   - Telecharger version Basic ^(gratuite^)
echo   - Installer ^(choisir dossier VST3^)
echo.
echo - [ ] **Dexed** - Telecharge dans %ARCHIVES_DIR%
echo   - Extraire dans `%VST_DIR%\VST3`
echo.
echo - [ ] **Magical 8bit Plug** - [ymck.net](http://www.ymck.net/en/download/magical8bitplug/^)
echo   - Sons NES ^(VST2 uniquement^)
echo.
echo ---
echo.
echo ## ✅ Etape 5 : Drums ^& Instruments
echo.
echo - [ ] **Sitala** - Telecharge dans %INSTALLERS_DIR%
echo   - Lancer l'installateur
echo.
echo - [ ] **MT Power Drum Kit** - [powerdrumkit.com](https://www.powerdrumkit.com/^)
echo   - Telechargement manuel requis
echo.
echo - [ ] **Spitfire LABS** - Via Spitfire App
echo   - Installer les packs souhaites ^(Strings, Piano, Choir...^)
echo.
echo - [ ] **Komplete Start** - Via Native Access
echo   - 2000+ sons gratuits
echo.
echo ---
echo.
echo ## ✅ Etape 6 : Effets
echo.
echo - [ ] **Valhalla Supermassive** - [valhalladsp.com](https://valhalladsp.com/shop/reverb/valhalla-supermassive/^)
echo   - Entrer email pour telecharger ^(gratuit^)
echo.
echo - [ ] **TDR Nova** - [tokyodawn.net](https://www.tokyodawn.net/tdr-nova/^)
echo   - EQ dynamique gratuit
echo.
echo - [ ] **OTT** - Telecharge dans %ARCHIVES_DIR%
echo   - Extraire dans `%VST_DIR%\VST`
echo.
echo ---
echo.
echo ## 🔧 Configuration finale Reaper
echo.
echo Apres installation de tous les plugins :
echo.
echo 1. Ouvrir Reaper
echo 2. `Options ^> Preferences ^> Plug-ins ^> VST`
echo 3. Cliquer `Re-scan`
echo 4. Verifier que tous les plugins apparaissent dans `FX Browser`
echo.
echo ### Test du MiniLab 3 :
echo.
echo 1. `Options ^> Preferences ^> MIDI Devices`
echo 2. Activer tous les ports "MiniLab 3"
echo 3. Creer une piste, armer, ajouter un VST ^(ex: Vital^)
echo 4. Jouer sur le clavier
echo.
echo ### Configuration ReaLearn :
echo.
echo 1. Ajouter ReaLearn en FX sur une piste ou le Master
echo 2. Configurer les mappings pour le MiniLab 3
echo 3. Documentation : https://www.helgoboss.org/projects/realearn/user-guide
echo.
echo ### Configuration MIDI Control Center ^(Arturia^) :
echo.
echo 1. Device Settings ^> Global Parameters
echo 2. Transport Mode: **Mackie** ^(pas "Both"^)
echo 3. Sauvegarder
echo.
echo ---
echo.
echo **Bon courage ! 🎵**
) > "%CHECKLIST_FILE%"

echo   ^> Checklist creee: %CHECKLIST_FILE%
echo.

REM ===============================================
REM Extraction automatique des archives
REM ===============================================

echo [5/6] Extraction des archives...
echo.

REM Vérifier si tar est disponible (Windows 10+)
where tar >nul 2>&1
if %errorlevel%==0 (
    REM Extraire Dexed
    if exist "%ARCHIVES_DIR%\dexed-windows.zip" (
        if not exist "%VST_DIR%\VST3\Dexed.vst3" (
            echo   Extraction de Dexed...
            tar -xf "%ARCHIVES_DIR%\dexed-windows.zip" -C "%VST_DIR%\VST3" 2>nul
            echo   ^> Dexed extrait dans %VST_DIR%\VST3
        ) else (
            echo   ^> Dexed deja extrait
        )
    )
    
    REM Extraire OTT
    if exist "%ARCHIVES_DIR%\OTT_Win.zip" (
        if not exist "%VST_DIR%\VST\OTT.dll" (
            echo   Extraction de OTT...
            tar -xf "%ARCHIVES_DIR%\OTT_Win.zip" -C "%VST_DIR%\VST" 2>nul
            echo   ^> OTT extrait dans %VST_DIR%\VST
        ) else (
            echo   ^> OTT deja extrait
        )
    )
) else (
    echo   ^> tar non disponible - extraire manuellement les archives
)

echo.

REM ===============================================
REM Résumé final
REM ===============================================

echo [6/6] Resume...
echo.
echo ╔══════════════════════════════════════════════════════════════════╗
echo ║                    ✅ SCRIPT TERMINE                             ║
echo ╚══════════════════════════════════════════════════════════════════╝
echo.
echo 📁 Dossiers crees:
echo    %DOWNLOAD_DIR%
echo    %VST_DIR%
echo.
echo 📥 Fichiers telecharges:
if exist "%ARCHIVES_DIR%\dexed-windows.zip" echo    ✅ Dexed
if exist "%INSTALLERS_DIR%\Sitala-Installer-Win64.exe" echo    ✅ Sitala
if exist "%ARCHIVES_DIR%\OTT_Win.zip" echo    ✅ OTT
echo.
echo 📋 Checklist d'installation:
echo    %CHECKLIST_FILE%
echo.
echo 👉 Prochaines etapes:
echo    1. Ouvrir la checklist et suivre les instructions
echo    2. Enregistrer le MiniLab 3 sur arturia.com
echo    3. Installer les gestionnaires (Native Access, Spitfire App)
echo    4. Telecharger et installer les plugins restants
echo    5. Configurer Reaper avec ReaLearn
echo.

REM Ouvrir la checklist
set /p OPEN_CHECKLIST="Ouvrir la checklist maintenant ? (O/n): "
if /i not "%OPEN_CHECKLIST%"=="n" (
    start "" "%CHECKLIST_FILE%"
)

echo.
echo 🎹 Bonne production musicale ! 🎵
echo.
pause
