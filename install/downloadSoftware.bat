@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion

echo ===============================================
echo Script de téléchargement des programmes (Modulaire)
echo ===============================================
echo.
echo Quel type d'installation souhaitez-vous?
echo   1. PC Fixe (installation complète)
echo   2. PC Portable (installation sans gaming et périphériques desktop)
echo.
set /p INSTALL_TYPE="Votre choix (1 ou 2): "

if "%INSTALL_TYPE%"=="1" (
    set "IS_DESKTOP=1"
    echo.
    echo Installation complète (PC Fixe) sélectionnée.
) else if "%INSTALL_TYPE%"=="2" (
    set "IS_DESKTOP=0"
    echo.
    echo Installation PC Portable sélectionnée.
    echo Les modules suivants seront exclus:
    echo   - Gaming
    echo   - Revo Uninstaller Pro
    echo   - DisplayLink Graphics
    echo   - Logitech G HUB
    echo   - Logi Options+
    echo   - Elgato Stream Deck
    echo   - Samsung Magician
) else (
    echo Choix invalide. Installation complète par défaut.
    set "IS_DESKTOP=1"
)
echo.
pause
echo.

REM Définir le répertoire de téléchargement
set "DOWNLOAD_DIR=%~dp0Downloads"
if not exist "%DOWNLOAD_DIR%" mkdir "%DOWNLOAD_DIR%"

echo Répertoire de téléchargement: %DOWNLOAD_DIR%
echo.
echo Architecture modulaire - Vous pouvez modifier chaque catégorie dans:
echo   modules\archives.bat
echo   modules\communication.bat
echo   modules\development.bat
echo   modules\gaming.bat
echo   modules\multimedia.bat
echo   modules\productivity.bat
echo   modules\security.bat
echo   modules\system-tools.bat
echo   modules\web.bat
echo.
echo Démarrage des téléchargements...
echo.

REM Appeler tous les modules
call "%~dp0modules\archives.bat"
call "%~dp0modules\communication.bat"
call "%~dp0modules\development.bat"

REM Gaming uniquement pour PC Fixe
if "%IS_DESKTOP%"=="1" (
    call "%~dp0modules\gaming.bat"
)

call "%~dp0modules\multimedia.bat"
call "%~dp0modules\productivity.bat"
call "%~dp0modules\security.bat"
call "%~dp0modules\system-tools.bat"
call "%~dp0modules\web.bat"

echo.
echo ===============================================
echo Téléchargements terminés!
echo ===============================================
echo.
echo Les fichiers sont dans: %DOWNLOAD_DIR%
echo.
echo ===============================================
echo PROGRAMMES NÉCESSITANT UN TÉLÉCHARGEMENT MANUEL
echo ===============================================
echo.
echo Sécurité:
echo   - Bitdefender Total Security
echo   - Acronis True Image
echo.
echo Outils système:
echo   - DisplayLink Graphics
echo   - Elgato Stream Deck
echo   - VMware Workstation
echo   - QNAP Qsync Client
echo   - Stardock Multiplicity
echo   - Shutter
echo.
echo Multimédia:
echo   - Wondershare Recoverit
echo.
echo Archives:
echo   - NanaZip
echo.
echo ===============================================
echo COMMENT AJOUTER/SUPPRIMER DES LOGICIELS
echo ===============================================
echo.
echo Pour ajouter un logiciel:
echo   1. Ouvrir le module correspondant dans modules\
echo   2. Ajouter une ligne avec call :DownloadSoftware
echo.
echo Pour supprimer un logiciel:
echo   1. Ouvrir le module correspondant dans modules\
echo   2. Commenter ou supprimer la ligne
echo.
echo Exemple:
echo   REM call :DownloadSoftware "Discord" "Discord.Discord" "" ""
echo.
pause
