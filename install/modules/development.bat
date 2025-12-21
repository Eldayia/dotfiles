@echo off
REM ===============================================
REM Module: Développement
REM ===============================================

call "%~dp0..\common\functions.bat"

echo.
echo === DÉVELOPPEMENT ===
echo.

REM ===============================================
REM Éditeurs de code et IDE
REM ===============================================

REM Visual Studio Code
call :DownloadSoftware "Visual Studio Code" "Microsoft.VisualStudioCode" "" ""

REM Cursor
call :DownloadSoftware "Cursor" "Cursor.Cursor" "https://downloader.cursor.sh/windows/nsis/x64" "CursorSetup.exe"

REM nano (éditeur texte en ligne de commande)
call :DownloadSoftware "nano" "GNU.Nano" "" ""

REM Neovim (éditeur texte modal)
call :DownloadSoftware "Neovim" "Neovim.Neovim" "" ""

REM Visual Studio Community 2026
call :DownloadSoftware "Visual Studio Community 2026" "Microsoft.VisualStudio.2026.Community" "" ""

REM Visual Studio Installer
call :IncludedWith "Visual Studio Installer" "Visual Studio"

REM Android Studio
call :DownloadSoftware "Android Studio" "Google.AndroidStudio" "" ""

REM ===============================================
REM Outils de contrôle de version
REM ===============================================

REM Git
call :DownloadSoftware "Git" "Git.Git" "" ""

REM GitKraken
call :DownloadSoftware "GitKraken" "Axosoft.GitKraken" "" ""

REM ===============================================
REM Langages de programmation et runtimes
REM ===============================================

REM Java Development Kit (JDK)
call :DownloadSoftware "OpenJDK 21" "Microsoft.OpenJDK.21" "" ""

REM .NET SDK (pour C#)
call :DownloadSoftware ".NET SDK" "Microsoft.DotNet.SDK.8" "" ""

REM Python 3.12
call :DownloadSoftware "Python 3.12" "Python.Python.3.12" "" ""

REM Rustup (Rust toolchain)
call :DownloadSoftware "Rustup" "Rustlang.Rustup" "" ""

REM Node.js (inclut npm)
call :DownloadSoftware "Node.js" "OpenJS.NodeJS" "" ""

REM ===============================================
REM Outils de build et compilation C++
REM ===============================================

REM CMake
call :DownloadSoftware "CMake" "Kitware.CMake" "" ""

REM LLVM (Clang)
call :DownloadSoftware "LLVM" "LLVM.LLVM" "" ""

REM MinGW-w64 (GCC pour Windows)
call :ManualDownloadRequired "MinGW-w64" "https://www.mingw-w64.org/"

REM Visual C++ Build Tools
call :IncludedWith "MSVC Build Tools" "Visual Studio Community 2026"

REM ===============================================
REM Outils JavaScript/TypeScript
REM ===============================================

REM TypeScript (installé via npm après Node.js)
REM npm install -g typescript

REM Vite (installé via npm après Node.js)
REM npm install -g vite

REM Vue CLI (installé via npm après Node.js)
REM npm install -g @vue/cli

REM ===============================================
REM Outils Android
REM ===============================================

REM Android SDK
call :IncludedWith "Android SDK" "Android Studio"

REM Android Platform Tools
call :IncludedWith "Android Platform Tools" "Android Studio"

REM Android Emulator
call :IncludedWith "Android Emulator" "Android Studio"

REM Gradle
call :IncludedWith "Gradle" "Android Studio"

REM ===============================================
REM Conteneurs et virtualisation
REM ===============================================

REM Docker Desktop
call :DownloadSoftware "Docker Desktop" "Docker.DockerDesktop" "https://desktop.docker.com/win/main/amd64/Docker%%20Desktop%%20Installer.exe" "Docker-Desktop-Installer.exe"

REM ===============================================
REM Outils IA et assistants
REM ===============================================

REM Claude Desktop
call :DownloadSoftware "Claude Desktop" "Anthropic.Claude" "" ""

REM Claude Code (installé via npm après Node.js)
REM npm install -g @anthropic-ai/claude-code

REM ===============================================
REM Outils de création de contenu interactif
REM ===============================================

REM Twine (création d'histoires interactives)
call :ManualDownloadRequired "Twine" "https://twinery.org/"

REM ===============================================
REM Note pour les outils npm
REM ===============================================
echo.
echo REMARQUE: Les outils suivants doivent être installés via npm après Node.js:
echo   - TypeScript: npm install -g typescript
echo   - Vite: npm install -g vite
echo   - Vue CLI: npm install -g @vue/cli
echo   - ESLint: npm install -g eslint
echo   - Prettier: npm install -g prettier
echo   - Claude Code: npm install -g @anthropic-ai/claude-code
echo.

goto :eof
