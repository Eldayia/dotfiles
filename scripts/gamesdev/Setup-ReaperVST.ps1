# ============================================================
# Configuration automatique des chemins VST dans Reaper
# ============================================================
# Ce script configure Reaper pour utiliser les plugins
# synchronisés via Qsync dans _Library/DAW/Plugins/
#
# Exécuter : .\Setup-ReaperVST.ps1
# ============================================================

$ErrorActionPreference = "Stop"

# Chemins
$ReaperIni = "$env:APPDATA\REAPER\reaper.ini"
$QsyncBase = "$env:USERPROFILE\Qsync\GamesDev\_Library\DAW\Plugins"

# Chemins VST à configurer
$VSTPath64 = @(
    "$QsyncBase\VST3",
    "$QsyncBase\VST",
    "$QsyncBase\CLAP"
) -join ","

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  Configuration Reaper - Chemins VST" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Vérifier que Reaper est installé
if (-not (Test-Path $ReaperIni)) {
    Write-Host "[!] Fichier reaper.ini non trouvé" -ForegroundColor Red
    Write-Host "    Chemin attendu : $ReaperIni" -ForegroundColor Gray
    Write-Host ""
    Write-Host "    Reaper n'est pas installé ou n'a jamais été lancé." -ForegroundColor Yellow
    Write-Host "    Lance Reaper une première fois puis relance ce script." -ForegroundColor Yellow
    Write-Host ""
    pause
    exit 1
}

# Vérifier que les dossiers Qsync existent
Write-Host "[1/4] Vérification des dossiers Qsync..." -ForegroundColor Yellow

$foldersExist = $true
foreach ($folder in @("VST3", "VST", "CLAP")) {
    $path = "$QsyncBase\$folder"
    if (Test-Path $path) {
        Write-Host "  [OK] $folder\" -ForegroundColor Green
    } else {
        Write-Host "  [--] $folder\ (non trouvé, sera créé)" -ForegroundColor Gray
        New-Item -ItemType Directory -Path $path -Force | Out-Null
        $foldersExist = $false
    }
}

# Fermer Reaper si ouvert
Write-Host ""
Write-Host "[2/4] Vérification que Reaper est fermé..." -ForegroundColor Yellow

$reaperProcess = Get-Process -Name "reaper" -ErrorAction SilentlyContinue
if ($reaperProcess) {
    Write-Host "  [!] Reaper est en cours d'exécution" -ForegroundColor Red
    Write-Host ""
    Write-Host "  Ferme Reaper puis appuie sur une touche pour continuer..." -ForegroundColor Yellow
    pause
    
    # Revérifier
    $reaperProcess = Get-Process -Name "reaper" -ErrorAction SilentlyContinue
    if ($reaperProcess) {
        Write-Host "  [!] Reaper est toujours ouvert. Abandon." -ForegroundColor Red
        exit 1
    }
}
Write-Host "  [OK] Reaper fermé" -ForegroundColor Green

# Backup du fichier ini
Write-Host ""
Write-Host "[3/4] Backup de reaper.ini..." -ForegroundColor Yellow

$backupPath = "$ReaperIni.backup-$(Get-Date -Format 'yyyyMMdd-HHmmss')"
Copy-Item -Path $ReaperIni -Destination $backupPath -Force
Write-Host "  [OK] Backup créé : $backupPath" -ForegroundColor Green

# Modifier le fichier ini
Write-Host ""
Write-Host "[4/4] Configuration des chemins VST..." -ForegroundColor Yellow

$content = Get-Content -Path $ReaperIni -Raw

# Pattern pour trouver vstpath64 (peut être sur plusieurs lignes avec des virgules)
if ($content -match '(?m)^vstpath64=.*?(?=\r?\n[a-z_]+=|\r?\n\[|$)') {
    # Remplacer l'existant
    $content = $content -replace '(?m)^vstpath64=.*?(?=\r?\n[a-z_]+=|\r?\n\[|$)', "vstpath64=$VSTPath64`r`n"
    Write-Host "  [OK] Chemins VST mis à jour" -ForegroundColor Green
} else {
    # Ajouter après [reaper]
    $content = $content -replace '(\[reaper\]\r?\n)', "`$1vstpath64=$VSTPath64`r`n"
    Write-Host "  [OK] Chemins VST ajoutés" -ForegroundColor Green
}

# Nettoyer les lignes vides multiples
$content = $content -replace '(\r?\n){3,}', "`r`n`r`n"

# Sauvegarder
Set-Content -Path $ReaperIni -Value $content -NoNewline
Write-Host "  [OK] reaper.ini sauvegardé" -ForegroundColor Green

# Résumé
Write-Host ""
Write-Host "========================================" -ForegroundColor Green
Write-Host "  Configuration terminée !" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
Write-Host ""
Write-Host "Chemins VST configurés :" -ForegroundColor White
Write-Host "  + $QsyncBase\VST3" -ForegroundColor Cyan
Write-Host "  + $QsyncBase\VST" -ForegroundColor Cyan
Write-Host "  + $QsyncBase\CLAP" -ForegroundColor Cyan
Write-Host ""
Write-Host "Prochaines étapes :" -ForegroundColor Yellow
Write-Host "  1. Lancer Reaper" -ForegroundColor White
Write-Host "  2. Aller dans Options > Preferences > Plug-ins > VST" -ForegroundColor White
Write-Host "  3. Cliquer sur 'Re-scan' pour détecter les plugins" -ForegroundColor White
Write-Host ""

pause
