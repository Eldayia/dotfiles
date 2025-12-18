@echo off
REM ===============================================
REM Module: Outils système
REM ===============================================

call "%~dp0..\common\functions.bat"

echo.
echo === OUTILS SYSTÈME ===
echo.

REM Périphériques desktop uniquement pour PC Fixe
if "%IS_DESKTOP%"=="1" (
    REM Samsung Magician
    call :DownloadSoftware "Samsung Magician" "Samsung.SamsungMagician" "" ""

    REM Elgato Stream Deck
    call :ManualDownloadRequired "Elgato Stream Deck" "https://www.elgato.com/"

    REM Logi Options+
    call :DownloadSoftware "Logi Options+" "Logitech.OptionsPlus" "" ""

    REM Logitech G HUB
    call :DownloadSoftware "Logitech G HUB" "Logitech.GHUB" "" ""

    REM DisplayLink Graphics
    call :ManualDownloadRequired "DisplayLink Graphics" "https://www.synaptics.com/products/displaylink-graphics"
)

REM Stardock Start11
call :DownloadSoftware "Stardock Start11" "Stardock.Start11" "" ""

REM Stardock Multiplicity
call :ManualDownloadRequired "Stardock Multiplicity" "https://www.stardock.com/"

REM TeamViewer
call :DownloadSoftware "TeamViewer" "TeamViewer.TeamViewer" "" ""

REM Revo Uninstaller Pro
call :DownloadSoftware "Revo Uninstaller Pro" "RevoUninstaller.RevoUninstallerPro" "" ""

REM VMware Workstation
call :ManualDownloadRequired "VMware Workstation" "https://www.vmware.com/"

REM QNAP Qsync Client
call :ManualDownloadRequired "QNAP Qsync Client" "https://www.qnap.com/"

REM Raspberry Pi Imager
call :DownloadSoftware "Raspberry Pi Imager" "RaspberryPiFoundation.RaspberryPiImager" "" ""

REM OrcaSlicer
call :DownloadSoftware "OrcaSlicer" "SoftFever.OrcaSlicer" "" ""

REM Comet
call :DownloadSoftware "Comet" "115.Comet" "" ""

REM LM Studio
call :DownloadSoftware "LM Studio" "LMStudio.LMStudio" "https://releases.lmstudio.ai/windows/latest/LM-Studio-Setup.exe" "LM-Studio-Setup.exe"

REM Shutter
call :ManualDownloadRequired "Shutter" ""

goto :eof
