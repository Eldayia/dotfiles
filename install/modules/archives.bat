@echo off
REM ===============================================
REM Module: Outils d'archivage et compression
REM ===============================================

call "%~dp0..\common\functions.bat"

echo.
echo === ARCHIVES ^& COMPRESSION ===
echo.

REM NanaZip (7-Zip moderne avec interface Windows 11)
call :DownloadSoftware "NanaZip" "M2Team.NanaZip" "" ""

goto :eof
