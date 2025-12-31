@echo off
REM ===============================================
REM Module: Productivité
REM ===============================================

call "%~dp0..\common\functions.bat"

echo.
echo === PRODUCTIVITÉ ===
echo.

REM ===============================================
REM Suite bureautique
REM ===============================================

REM Microsoft 365 Famille
call :DownloadSoftware "Microsoft 365" "Microsoft.Office" "" ""

REM ===============================================
REM Gestionnaires de mots de passe
REM ===============================================

REM 1Password
call :DownloadSoftware "1Password" "AgileBits.1Password" "https://downloads.1password.com/win/1PasswordSetup-latest.exe" "1PasswordSetup.exe"

REM 1Password CLI
call :DownloadSoftware "1Password CLI" "AgileBits.1Password.CLI" "https://downloads.1password.com/win/1password-cli-latest.zip" "1password-cli.zip"

REM PowerToys
call :DownloadSoftware "PowerToys" "Microsoft.PowerToys" "" ""

REM Rainmeter
call :DownloadSoftware "Rainmeter" "Rainmeter.Rainmeter" "" ""

REM FileZilla
call :DownloadSoftware "FileZilla" "TimKosse.FileZilla.Client" "" ""

REM WinSCP
call :DownloadSoftware "WinSCP" "WinSCP.WinSCP" "" ""

REM eM Client
call :DownloadSoftware "eM Client" "eMClient.eMClient" "" ""

REM TreeSize
call :DownloadSoftware "TreeSize" "JAMSoftware.TreeSize.Free" "" ""

REM UltraSearch
call :DownloadSoftware "UltraSearch" "JAMSoftware.UltraSearch" "" ""

REM UniGetUI
call :DownloadSoftware "UniGetUI" "MartiCliment.UniGetUI" "" ""

REM Warp Terminal
call :DownloadSoftware "Warp" "Warp.Warp" "" ""

REM UPDF
call :DownloadSoftware "UPDF" "Superace.UPDF" "https://www.updf.com/downloads/updf-win.exe" "UPDF-Setup.exe"

REM Wondershare Recoverit
call :ManualDownloadRequired "Wondershare Recoverit" "https://recoverit.wondershare.com/"

REM ReNamer
call :DownloadSoftware "ReNamer" "DenisKozlov.ReNamer" "" ""

REM Eagle (gestionnaire d'assets pour designers)
call :DownloadSoftware "Eagle" "ogdesign.Eagle" "https://eaglefile.oss-cn-shanghai.aliyuncs.com/releases/Eagle-4.0-build66.exe" "EagleSetup.exe"

REM Obsidian
call :DownloadSoftware "Obsidian" "Obsidian.Obsidian" "" ""

REM ===============================================
REM Capture d'écran et productivité
REM ===============================================

REM ShareX (capture d'écran avancée)
call :DownloadSoftware "ShareX" "ShareX.ShareX" "" ""

REM Monica (assistant IA personnel)
call :DownloadSoftware "Monica" "ButterflyEffect.Monica" "" ""

REM ===============================================
REM Gestion de fichiers
REM ===============================================

REM LockHunter (débloquer fichiers verrouillés)
call :DownloadSoftware "LockHunter" "CrystalRich.LockHunter" "" ""

REM TeraCopy (copie de fichiers améliorée)
call :DownloadSoftware "TeraCopy" "CodeSector.TeraCopy" "" ""

goto :eof
