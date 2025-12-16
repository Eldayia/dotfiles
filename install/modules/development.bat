@echo off
REM ===============================================
REM Module: Développement
REM ===============================================

call "%~dp0..\common\functions.bat"

echo.
echo === DÉVELOPPEMENT ===
echo.

REM Git
call :DownloadSoftware "Git" "Git.Git" "" ""

REM Visual Studio Code
call :DownloadSoftware "Visual Studio Code" "Microsoft.VisualStudioCode" "" ""

REM Cursor
call :DownloadSoftware "Cursor" "Cursor.Cursor" "https://downloader.cursor.sh/windows/nsis/x64" "CursorSetup.exe"

REM CMake
call :DownloadSoftware "CMake" "Kitware.CMake" "" ""

REM Node.js
call :DownloadSoftware "Node.js" "OpenJS.NodeJS" "" ""

REM Python 3.12
call :DownloadSoftware "Python 3.12" "Python.Python.3.12" "" ""

REM Rustup
call :DownloadSoftware "Rustup" "Rustlang.Rustup" "" ""

REM Docker Desktop
call :DownloadSoftware "Docker Desktop" "Docker.DockerDesktop" "https://desktop.docker.com/win/main/amd64/Docker%%20Desktop%%20Installer.exe" "Docker-Desktop-Installer.exe"

REM GitKraken
call :DownloadSoftware "GitKraken" "Axosoft.GitKraken" "" ""

REM Visual Studio Community 2026
call :DownloadSoftware "Visual Studio Community 2026" "Microsoft.VisualStudio.2026.Community" "" ""

REM Visual Studio Installer
call :IncludedWith "Visual Studio Installer" "Visual Studio"

goto :eof
