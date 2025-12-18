# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Personal dotfiles repository for Windows and Linux configurations. Currently focused on Windows with modular installation scripts for automated software setup via Winget. Supports 75+ software packages covering development tools, productivity, gaming, multimedia, and system utilities.

## Architecture

```
dotfiles/
├── install/                    # Windows installation system
│   ├── downloadSoftware.bat    # Main entry point (Desktop/Laptop choice)
│   ├── common/functions.bat    # Shared functions (DownloadSoftware, ManualDownloadRequired, IncludedWith)
│   └── modules/                # Category-based software modules
│       ├── archives.bat
│       ├── communication.bat
│       ├── development.bat
│       ├── gaming.bat          # Desktop only
│       ├── multimedia.bat
│       ├── productivity.bat
│       ├── security.bat
│       ├── system-tools.bat    # Conditional items for Desktop
│       └── web.bat
├── scripts/
│   └── stow-claude-agents.ps1  # Symlink manager for Claude agents
└── .config/claude/             # Claude Code agent definitions
```

### Installation System Pattern

Modules use three functions from `common/functions.bat`:

```batch
REM Download via Winget with curl fallback
call :DownloadSoftware "Name" "Winget.ID" "fallback_url" "filename.exe"

REM Manual download notice
call :ManualDownloadRequired "Name" "download_url"

REM Bundled software notice
call :IncludedWith "Name" "Parent Software"
```

The main script (`downloadSoftware.bat`) prompts for Desktop (full) vs Laptop (excludes gaming, peripherals) installation.

### Development Environment Coverage

The `development.bat` module provides comprehensive tooling for:
- **C++**: LLVM/Clang, MinGW-w64, CMake, MSVC Build Tools
- **C#**: .NET SDK 8
- **Python**: Python 3.12
- **Rust**: Rustup toolchain
- **Java**: OpenJDK 21
- **JavaScript/TypeScript**: Node.js, npm + post-install tools (TypeScript, Vite, Vue CLI, ESLint, Prettier)
- **Android**: Android Studio with SDK, Platform Tools, Emulator, Gradle
- **Containers**: Docker Desktop

Post-installation npm packages (run after Node.js install):
```batch
npm install -g typescript vite @vue/cli eslint prettier
```

### System-tools Changes

- **Revo Uninstaller Pro** is now installed on ALL PCs (previously Desktop-only)
- Peripheral-specific software (Samsung Magician, Logitech G HUB, Elgato Stream Deck, DisplayLink) remain Desktop-only

### Claude Agents Stow System

`scripts/stow-claude-agents.ps1` manages Claude agent configs as dotfiles:
- Creates symlink: `~/.claude/agents` → `~/dotfiles/.config/claude`
- Supports: init, stow, unstow, pull, push, status, adopt
- Requires Windows Developer Mode or Admin for symlinks

## Commands

```powershell
# Run full Windows software installation
.\install\downloadSoftware.bat

# Run specific module
.\install\modules\development.bat

# Manage Claude agents
.\scripts\stow-claude-agents.ps1              # Interactive menu
.\scripts\stow-claude-agents.ps1 -Action init # Direct action
```

## Conventions

- PowerShell for Windows scripts, Bash for Linux
- Batch files use REM comments and `call :FunctionName` pattern
- Variables: `%DOWNLOAD_DIR%` available across all modules
- Always communicate in French with the user
