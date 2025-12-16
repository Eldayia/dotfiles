@echo off
REM ===============================================
REM Module: Outils d'archivage et compression
REM ===============================================

call "%~dp0..\common\functions.bat"

echo.
echo === ARCHIVES ^& COMPRESSION ===
echo.

REM NanaZip
call :ManualDownloadRequired "NanaZip" "https://github.com/M2Team/NanaZip/releases"

goto :eof
