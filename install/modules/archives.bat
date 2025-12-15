@echo off
REM ===============================================
REM Module: Outils d'archivage et compression
REM ===============================================

call "%~dp0..\common\functions.bat"

echo.
echo === ARCHIVES ^& COMPRESSION ===
echo.

REM 7-Zip
call :DownloadSoftware "7-Zip" "7zip.7zip" "https://www.7-zip.org/a/7z2501-x64.exe" "7z-x64.exe"

REM NanaZip
call :ManualDownloadRequired "NanaZip" "https://github.com/M2Team/NanaZip/releases"

goto :eof
