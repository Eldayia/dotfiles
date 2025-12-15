@echo off
REM ===============================================
REM Fonctions communes pour le téléchargement
REM ===============================================

REM Fonction: Télécharger un logiciel avec winget puis fallback curl
REM Usage: call :DownloadSoftware "Nom" "ID_Winget" "URL_Fallback" "Nom_Fichier"
:DownloadSoftware
    set "SW_NAME=%~1"
    set "SW_ID=%~2"
    set "SW_URL=%~3"
    set "SW_FILE=%~4"
    
    echo [%SW_NAME%]
    
    REM Essayer avec winget d'abord
    winget download --id "%SW_ID%" --download-folder "%DOWNLOAD_DIR%\%SW_NAME%" 2>nul
    
    if errorlevel 1 (
        REM Si winget échoue, essayer curl si URL fournie
        if not "%SW_URL%"=="" (
            echo   ^> Téléchargement alternatif...
            curl -L -o "%DOWNLOAD_DIR%\%SW_FILE%" "%SW_URL%" 2>nul
        ) else (
            echo   ^> Non disponible sur winget
        )
    )
    
    goto :eof

REM Fonction: Afficher un message de téléchargement manuel requis
REM Usage: call :ManualDownloadRequired "Nom" "URL"
:ManualDownloadRequired
    set "SW_NAME=%~1"
    set "SW_URL=%~2"
    
    echo [%SW_NAME%]
    echo   ^> Non disponible - téléchargement manuel requis
    if not "%SW_URL%"=="" (
        echo   ^> %SW_URL%
    )
    
    goto :eof

REM Fonction: Programme inclus avec un autre
REM Usage: call :IncludedWith "Nom" "Inclus_Dans"
:IncludedWith
    set "SW_NAME=%~1"
    set "INCLUDED_IN=%~2"
    
    echo [%SW_NAME%]
    echo   ^> Inclus avec %INCLUDED_IN%
    
    goto :eof
