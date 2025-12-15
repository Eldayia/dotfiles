@echo off
REM ===============================================
REM Module: Sécurité
REM ===============================================

call "%~dp0..\common\functions.bat"

echo.
echo === SÉCURITÉ ===
echo.

REM Bitdefender Total Security
call :ManualDownloadRequired "Bitdefender Total Security" "https://www.bitdefender.com/"

REM NordVPN
call :DownloadSoftware "NordVPN" "NordVPN.NordVPN" "" ""

REM Acronis True Image
call :ManualDownloadRequired "Acronis True Image" "https://www.acronis.com/"

goto :eof
