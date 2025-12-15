@echo off
REM ===============================================
REM Module: Communication
REM ===============================================

call "%~dp0..\common\functions.bat"

echo.
echo === COMMUNICATION ===
echo.

REM Discord
call :DownloadSoftware "Discord" "Discord.Discord" "https://discord.com/api/download?platform=win" "DiscordSetup.exe"

goto :eof
