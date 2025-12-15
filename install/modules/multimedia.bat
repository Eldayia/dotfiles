@echo off
REM ===============================================
REM Module: Multimédia
REM ===============================================

call "%~dp0..\common\functions.bat"

echo.
echo === MULTIMÉDIA ===
echo.

REM VLC media player
call :DownloadSoftware "VLC media player" "VideoLAN.VLC" "" ""

REM Mp3tag
call :DownloadSoftware "Mp3tag" "Florian.Heidenreich.Mp3tag" "" ""

REM Apple Music
call :DownloadSoftware "Apple Music" "Apple.AppleMusic" "" ""

REM Adobe Creative Cloud
call :DownloadSoftware "Adobe Creative Cloud" "Adobe.CreativeCloud" "https://creativecloud.adobe.com/apps/download/creative-cloud" "CreativeCloudSetup.exe"

REM qBittorrent
call :DownloadSoftware "qBittorrent" "qBittorrent.qBittorrent" "" ""

goto :eof
