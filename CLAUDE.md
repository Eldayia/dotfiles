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

## Claude Agents Available

22 specialized agents are available in `.config/claude/` for different development tasks:

### Development & Code Quality
- **android-code** - Expert Android Kotlin developer (MVVM, Jetpack Compose, Material You)
- **android-build** - Gradle build system expert (compilation, debugging, optimization)
- **kotlin** - Elite Android/Kotlin developer (architecture, performance, security)
- **code-reviewer** - Multi-language code review (quality, patterns, security)
- **code-viewer** - Syntax highlighting and code visualization on Android
- **windows-scripting** - Batch and PowerShell scripting expert

### Android-Specific Specialists
- **compose-navigation** - Jetpack Compose navigation (type-safe routes, deep links, animations)
- **material-you-design** - Material Design 3 / Material You theming expert
- **github-api** - GitHub REST v3 and GraphQL v4 API integration
- **git-operations** - Native Git operations on Android with JGit
- **notifications-handler** - GitHub notifications system (FCM, polling, deep linking)
- **offline-sync** - Offline-first architecture (Room, WorkManager, sync strategies)

### Architecture & Design
- **agent-architect** - Design and create autonomous AI agent configurations
- **project-todolist** - Project analysis and roadmap generation

### Documentation & Web
- **doc-writer** - Technical documentation (README, API docs, CHANGELOG)
- **web-design** - Modern web design analysis (accessibility, UX/UI, performance)

### Tools & Utilities
- **docker-compose-helper** - Docker Compose optimization and debugging
- **git-helper** - Git workflows and Conventional Commits
- **nix-flake** - Nix/NixOS flakes and development environments
- **security-auditor** - Security audit (OWASP, secrets, dependencies)

### Creative & Assets
- **eagle-maker** - RPG Maker MZ asset organization for Eagle
- **image-logo-generator** - Visual asset creation (logos, icons, UI graphics)

Use agents with the Task tool in Claude Code for specialized assistance on specific tasks.

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
