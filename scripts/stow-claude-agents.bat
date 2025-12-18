@echo off
REM Lanceur pour stow-claude-agents.ps1 (bypass ExecutionPolicy)
powershell -ExecutionPolicy Bypass -File "%~dp0stow-claude-agents.ps1" %*
pause
