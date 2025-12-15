@echo off
REM ===============================================
REM Module: Navigateurs web
REM ===============================================

call "%~dp0..\common\functions.bat"

echo.
echo === NAVIGATEURS WEB ===
echo.

REM Google Chrome
call :DownloadSoftware "Google Chrome" "Google.Chrome" "" ""

REM Google Chrome Canary
call :DownloadSoftware "Google Chrome Canary" "Google.Chrome.Canary" "" ""

goto :eof
