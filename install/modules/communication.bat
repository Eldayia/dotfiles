@echo off
REM ===============================================
REM Module: Communication
REM ===============================================

call "%~dp0..\common\functions.bat"

echo.
echo === COMMUNICATION ===
echo.

REM Vesktop (Discord client alternatif open-source)
call :DownloadSoftware "Vesktop" "Vencord.Vesktop" "" ""

goto :eof
