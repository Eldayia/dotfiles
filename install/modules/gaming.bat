@echo off
REM ===============================================
REM Module: Gaming (Plateformes de jeux)
REM ===============================================

call "%~dp0..\common\functions.bat"

echo.
echo === GAMING ===
echo.

REM Steam
call :DownloadSoftware "Steam" "Valve.Steam" "" ""

REM Epic Games Launcher
call :DownloadSoftware "Epic Games Launcher" "EpicGames.EpicGamesLauncher" "https://launcher-public-service-prod06.ol.epicgames.com/launcher/api/installer/download/EpicGamesLauncherInstaller.msi" "EpicInstaller.msi"

REM Epic Online Services
call :IncludedWith "Epic Online Services" "Epic Games Launcher"

REM GOG GALAXY
call :DownloadSoftware "GOG GALAXY" "GOG.Galaxy" "https://webinstallers.gog-statics.com/download/GOG_Galaxy_2.0.exe" "GOG-Galaxy-Setup.exe"

REM Battle.net
call :DownloadSoftware "Battle.net" "Blizzard.BattleNet" "https://downloader.battle.net/download/getInstaller?os=win&installer=Battle.net-Setup.exe" "Battle.net-Setup.exe"

REM EA app
call :DownloadSoftware "EA app" "ElectronicArts.EADesktop" "https://origin-a.akamaihd.net/EA-Desktop-Client-Download/installer-releases/EAappInstaller.exe" "EAappInstaller.exe"

REM Ubisoft Connect
call :DownloadSoftware "Ubisoft Connect" "Ubisoft.Connect" "" ""

REM Amazon Games
call :DownloadSoftware "Amazon Games" "Amazon.Games" "https://download.amazongames.com/AmazonGamesSetup.exe" "AmazonGamesSetup.exe"

REM Riot Client
call :DownloadSoftware "Riot Client" "RiotGames.LeagueOfLegends.EUW" "" ""

REM Wargaming.net Game Center
call :DownloadSoftware "Wargaming.net Game Center" "Wargaming.GameCenter" "" ""

REM HoYoPlay
call :DownloadSoftware "HoYoPlay" "Cognosphere.HoYoPlay" "" ""

REM BlueStacks
call :DownloadSoftware "BlueStacks" "BlueStack.BlueStacks" "https://cdn3.bluestacks.com/downloads/windows/nxt/latest/BlueStacksInstaller.exe" "BlueStacksInstaller.exe"

REM Google Play Games (jeux Android sur PC)
call :DownloadSoftware "Google Play Games" "Google.PlayGames" "" ""

REM CurseForge
call :DownloadSoftware "CurseForge" "Overwolf.CurseForge" "https://curseforge.overwolf.com/downloads/curseforge-latest-x64.exe" "CurseForge-Setup.exe"

REM Ankama Launcher
call :DownloadSoftware "Ankama Launcher" "Ankama.AnkamaLauncher" "https://launcher.cdn.ankama.com/installers/production/Ankama%%20Launcher-Setup.exe" "Ankama-Launcher-Setup.exe"

goto :eof
