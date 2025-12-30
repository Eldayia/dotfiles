@echo off
REM ===============================================
REM Module: Audio Production (DAW, Plugins, MiniLab 3)
REM ===============================================

call "%~dp0..\common\functions.bat"

echo.
echo === AUDIO PRODUCTION - DAW ^& Plugins ===
echo.

REM ===============================================
REM DAW (Digital Audio Workstation)
REM ===============================================

echo --- DAW ---
echo.

REM FL Studio
call :DownloadSoftware "FL Studio" "ImageLine.FLStudio" "https://www.image-line.com/fl-studio-download/" "FLStudio-Setup.exe"

REM FL Cloud Plugins (inclus avec FL Studio)
call :IncludedWith "FL Cloud Plugins" "FL Studio"

REM FL Studio ASIO (inclus avec FL Studio)
call :IncludedWith "FL Studio ASIO" "FL Studio"

REM Reaper
call :DownloadSoftware "Reaper" "Cockos.REAPER" "https://www.reaper.fm/files/7.x/reaper757_x64-install.exe" "reaper-install.exe"

REM ===============================================
REM Configuration ASIO
REM ===============================================

echo.
echo --- DRIVERS ASIO ---
echo.

REM ASIO4ALL (driver ASIO universel)
call :DownloadSoftware "ASIO4ALL" "MichaelTippach.ASIO4ALL" "" ""

REM ===============================================
REM Gestionnaires de plugins
REM ===============================================

echo.
echo --- GESTIONNAIRES DE PLUGINS ---
echo.

REM Native Access (gestionnaire Native Instruments)
call :DownloadSoftware "Native Access" "NativeInstruments.NativeAccess" "https://www.native-instruments.com/fileadmin/ni_media/downloads/Native-Access_2.exe" "Native-Access.exe"

REM Waves Central (gestionnaire Waves)
call :DownloadSoftware "Waves Central" "WavesAudio.WavesCentral" "" ""

REM Cosmos (gestionnaire Waves)
call :ManualDownloadRequired "Cosmos" "https://www.waves.com/cosmos"

REM Softube Central
call :ManualDownloadRequired "Softube Central" "https://www.softube.com/central"

REM Splice (pour samples et plugins rent-to-own)
call :DownloadSoftware "Splice" "Splice.Splice" "https://splice.com/download" "splice-installer.exe"

REM Splice Bridge (via Splice)
call :IncludedWith "Splice Bridge" "Splice (activer dans l'app)"

REM Splice INSTRUMENT (via Splice)
call :IncludedWith "Splice INSTRUMENT" "Splice (activer dans l'app)"

REM Spitfire Audio App
call :ManualDownloadRequired "Spitfire Audio App" "https://www.spitfireaudio.com/info/library-manager"

REM ===============================================
REM Configuration MiniLab 3 (Arturia)
REM ===============================================

echo.
echo --- ARTURIA MiniLab 3 ---
echo.

REM MIDI Control Center (obligatoire pour MiniLab 3)
call :ManualDownloadRequired "MIDI Control Center" "https://www.arturia.com/support/downloads&manuals"

REM Melodics (apprentissage piano/clavier)
call :ManualDownloadRequired "Melodics" "https://melodics.com/download"

REM Analog Lab Intro (inclus avec MiniLab 3)
call :IncludedWith "Analog Lab Intro" "MiniLab 3 (enregistrer sur arturia.com)"

REM UVI Model D (inclus avec MiniLab 3)
call :IncludedWith "UVI Model D" "MiniLab 3 (code fourni)"

REM Native Instruments The Gentleman (inclus avec MiniLab 3)
call :IncludedWith "NI The Gentleman" "MiniLab 3 (code fourni, via Native Access)"

REM ===============================================
REM Plugin Reaper - ReaLearn (obligatoire pour MiniLab 3)
REM ===============================================

echo.
echo --- REAPER PLUGINS ---
echo.

REM ReaLearn (Helgobox)
call :ManualDownloadRequired "ReaLearn (Helgobox)" "https://github.com/helgoboss/helgobox/releases/latest"

REM ===============================================
REM Synthétiseurs VST
REM ===============================================

echo.
echo --- SYNTHETISEURS VST ---
echo.

REM Vital (synthé wavetable - compte gratuit requis)
call :ManualDownloadRequired "Vital (Basic)" "https://vital.audio/"

REM Surge XT (synthé hybride gratuit)
call :DownloadSoftware "Surge XT" "SurgeSynth.SurgeXT" "" ""

REM Dexed (émulation Yamaha DX7)
call :ManualDownloadRequired "Dexed" "https://github.com/asb2m10/dexed/releases/latest"

REM Magical 8bit Plug (chiptune NES)
call :ManualDownloadRequired "Magical 8bit Plug" "http://www.ymck.net/en/download/magical8bitplug/"

REM ===============================================
REM Instruments samplés
REM ===============================================

echo.
echo --- INSTRUMENTS SAMPLES ---
echo.

REM Kontakt 8 (via Native Access)
call :IncludedWith "Kontakt 8" "Native Access (télécharger dans l'app)"

REM Guitar Rig 7 (via Native Access)
call :IncludedWith "Guitar Rig 7" "Native Access"

REM Massive X (via Native Access)
call :IncludedWith "Massive X" "Native Access"

REM Raum (reverb, via Native Access)
call :IncludedWith "Raum" "Native Access"

REM Replika (delay, via Native Access)
call :IncludedWith "Replika" "Native Access"

REM Supercharger (compresseur, via Native Access)
call :IncludedWith "Supercharger" "Native Access"

REM Spitfire LABS (65 packs gratuits)
call :IncludedWith "Spitfire LABS" "Spitfire Audio App (créer compte gratuit)"

REM Komplete Start (2000+ sons gratuits)
call :IncludedWith "Komplete Start" "Native Access (créer compte gratuit)"

REM Plogue sforzando (lecteur SFZ)
call :ManualDownloadRequired "Plogue sforzando" "https://www.plogue.com/downloads.html#sforzando"

REM ARIA Engine (pour sforzando)
call :IncludedWith "ARIA Engine" "Plogue sforzando"

REM ===============================================
REM Batteries / Drums
REM ===============================================

echo.
echo --- BATTERIES ^& DRUMS ---
echo.

REM Sitala (drum machine)
call :ManualDownloadRequired "Sitala" "https://decomposer.de/sitala/"

REM Beatmaker (drum/beat)
call :ManualDownloadRequired "Beatmaker" "https://ujam.com/beatmaker/"

REM MT Power Drum Kit
call :ManualDownloadRequired "MT Power Drum Kit" "https://www.powerdrumkit.com/download76187.php"

REM ===============================================
REM Effets VST - Reverb/Delay
REM ===============================================

echo.
echo --- EFFETS REVERB/DELAY ---
echo.

REM Valhalla Supermassive (reverb/delay gratuit)
call :ManualDownloadRequired "Valhalla Supermassive" "https://valhalladsp.com/shop/reverb/valhalla-supermassive/"

REM TAL-Chorus-LX (chorus vintage gratuit)
call :ManualDownloadRequired "TAL-Chorus-LX" "https://tal-software.com/products/tal-chorus-lx"

REM ===============================================
REM Effets VST - EQ/Dynamics
REM ===============================================

echo.
echo --- EFFETS EQ/DYNAMICS ---
echo.

REM TDR Nova (EQ dynamique gratuit)
call :ManualDownloadRequired "TDR Nova" "https://www.tokyodawn.net/tdr-nova/"

REM OTT (compression multiband gratuit)
call :ManualDownloadRequired "OTT (Xfer)" "https://xferrecords.com/freeware"

REM Ozone Imager 2 (stereo imaging gratuit)
call :ManualDownloadRequired "Ozone Imager 2" "https://www.izotope.com/en/products/ozone-imager.html"

REM Ozone 12 Equalizer (via iZotope Product Portal)
call :ManualDownloadRequired "Ozone 12 Equalizer" "https://www.izotope.com/"

REM ===============================================
REM Effets VST - Saturation/Distortion
REM ===============================================

echo.
echo --- EFFETS SATURATION ---
echo.

REM Softube Saturation Knob (gratuit)
call :ManualDownloadRequired "Softube Saturation Knob" "https://www.softube.com/saturationknob"

REM Trash (distorsion iZotope)
call :ManualDownloadRequired "Trash" "https://www.izotope.com/en/products/trash.html"

REM Vinyl (vinyl effect iZotope - gratuit)
call :ManualDownloadRequired "Vinyl" "https://www.izotope.com/en/products/vinyl.html"

REM ===============================================
REM Effets VST - Utilitaires
REM ===============================================

echo.
echo --- EFFETS UTILITAIRES ---
echo.

REM Voxengo SPAN (analyseur spectral gratuit)
call :ManualDownloadRequired "Voxengo SPAN" "https://www.voxengo.com/product/span/"

REM Voxengo MSED (mid/side encoder gratuit)
call :ManualDownloadRequired "Voxengo MSED" "https://www.voxengo.com/product/msed/"

REM Youlean Loudness Meter 2 (mesure LUFS gratuit)
call :ManualDownloadRequired "Youlean Loudness Meter 2" "https://youlean.co/youlean-loudness-meter/"

REM Cableguys PanCake (pan automatique)
call :ManualDownloadRequired "Cableguys PanCake" "https://www.cableguys.com/pancake.html"

REM MPluginManager (organisateur VST)
call :ManualDownloadRequired "MPluginManager" "https://www.meldaproduction.com/MPluginManager"

REM ===============================================
REM Script d'installation avancé
REM ===============================================

echo.
echo ===============================================
echo SCRIPT D'INSTALLATION AVANCE
echo ===============================================
echo.
echo Un script complet est disponible:
echo   dotfiles\scripts\audioproduction\Setup-AudioProduction.bat
echo.
echo Ce script:
echo   - Telecharge automatiquement certains plugins (Dexed, Sitala, OTT)
echo   - Ouvre les pages web pour les autres
echo   - Genere une checklist Markdown
echo   - Extrait les archives dans les dossiers VST
echo.
echo Pour l'executer:
echo   "%%USERPROFILE%%\dotfiles\scripts\audioproduction\Setup-AudioProduction.bat"
echo.

REM ===============================================
REM Instructions post-installation
REM ===============================================

echo ===============================================
echo CONFIGURATION POST-INSTALLATION AUDIO
echo ===============================================
echo.
echo 1. MINILAB 3:
echo    - Enregistrer le clavier sur arturia.com
echo    - Installer MIDI Control Center
echo    - Installer Analog Lab Intro
echo    - Récupérer les codes UVI Model D et NI The Gentleman
echo.
echo 2. NATIVE ACCESS:
echo    - Se connecter ou créer compte
echo    - Entrer le code NI The Gentleman (MiniLab 3)
echo    - Télécharger Komplete Start (gratuit)
echo.
echo 3. SPITFIRE AUDIO:
echo    - Installer Spitfire Audio App
echo    - Créer compte gratuit
echo    - Télécharger les packs LABS souhaités
echo.
echo 4. REAPER - Configuration MiniLab 3:
echo    a. Installer ReaLearn (helgobox-windows-x64.msi)
echo    b. Dans Reaper: Options ^> Preferences ^> MIDI Devices
echo       - Activer tous les ports MiniLab 3
echo    c. Dans MIDI Control Center (Arturia):
echo       - Device Settings ^> Global Parameters
echo       - Transport Mode: Mackie (pas "Both")
echo    d. Ajouter ReaLearn en FX pour mapper les contrôles
echo.
echo 5. CHEMINS VST REAPER:
echo    Options ^> Preferences ^> Plug-ins ^> VST
echo    Ajouter:
echo      %%USERPROFILE%%\Qsync\GamesDev\_Library\DAW\Plugins\VST
echo      %%USERPROFILE%%\Qsync\GamesDev\_Library\DAW\Plugins\VST3
echo      %%USERPROFILE%%\Qsync\GamesDev\_Library\DAW\Plugins\CLAP
echo    Puis: Re-scan
echo.

goto :eof
