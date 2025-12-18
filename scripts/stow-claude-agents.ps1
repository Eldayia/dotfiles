<#
.SYNOPSIS
    Stow-style pour synchroniser les agents Claude Code via dotfiles.

.DESCRIPTION
    Gere les agents Claude Code comme des dotfiles :
    - Clone/pull depuis le repo dotfiles (branche windows)
    - Cree un symlink ~/.claude/agents -> ~/dotfiles/.config/claude
    - Push les modifications vers GitHub

.NOTES
    Repo: https://github.com/Eldayia/dotfiles.git (branche windows)
    Chemin repo: ~/dotfiles/.config/claude
    Symlink: ~/.claude/agents -> ~/dotfiles/.config/claude
#>

[CmdletBinding()]
param(
    [Parameter(Mandatory = $false)]
    [ValidateSet('init', 'stow', 'unstow', 'pull', 'push', 'status', 'adopt', 'menu')]
    [string]$Action = 'menu',

    [Parameter(Mandatory = $false)]
    [string]$Message = "Update claude agents"
)

# ==============================================================================
# Configuration
# ==============================================================================

$Config = @{
    RepoUrl       = "https://github.com/Eldayia/dotfiles.git"
    Branch        = "windows"

    DotfilesDir   = Join-Path $env:USERPROFILE "dotfiles"
    AgentsRepo    = Join-Path $env:USERPROFILE "dotfiles\.config\claude"
    ClaudeDir     = Join-Path $env:USERPROFILE ".claude"
    SymlinkPath   = Join-Path $env:USERPROFILE ".claude\agents"
}

# ==============================================================================
# Helpers
# ==============================================================================

function Write-Status { param($Icon, $Message, $Color = "White")
    Write-Host "$Icon " -NoNewline -ForegroundColor $Color
    Write-Host $Message
}
function Write-OK { param($Message) Write-Status "[OK]" $Message "Green" }
function Write-Info { param($Message) Write-Status "[->]" $Message "Cyan" }
function Write-Warn { param($Message) Write-Status "[!!]" $Message "Yellow" }
function Write-Err { param($Message) Write-Status "[X]" $Message "Red" }

function Test-CanSymlink {
    $testPath = Join-Path $env:TEMP "symlink-test-$(Get-Random)"
    $testTarget = Join-Path $env:TEMP "symlink-target-$(Get-Random)"

    try {
        New-Item -ItemType Directory -Path $testTarget -Force | Out-Null
        $null = New-Item -ItemType SymbolicLink -Path $testPath -Target $testTarget -ErrorAction Stop
        Remove-Item $testPath -Force
        Remove-Item $testTarget -Force
        return $true
    }
    catch {
        Remove-Item $testTarget -Force -ErrorAction SilentlyContinue
        return $false
    }
}

function Test-IsSymlink {
    param([string]$Path)
    if (-not (Test-Path $Path)) { return $false }
    $item = Get-Item $Path -Force
    return ($item.Attributes -band [IO.FileAttributes]::ReparsePoint) -ne 0
}

function Get-SymlinkTarget {
    param([string]$Path)
    if (-not (Test-IsSymlink $Path)) { return $null }
    return (Get-Item $Path).Target
}

# ==============================================================================
# Menu Interactif
# ==============================================================================

function Show-Menu {
    $menuItems = @(
        @{ Key = "init";   Label = "Initialiser";        Desc = "Clone le repo et cree le symlink" }
        @{ Key = "status"; Label = "Statut";             Desc = "Affiche l'etat actuel" }
        @{ Key = "pull";   Label = "Pull";               Desc = "Recupere les changements depuis GitHub" }
        @{ Key = "push";   Label = "Push";               Desc = "Envoie les modifications vers GitHub" }
        @{ Key = "adopt";  Label = "Adopter";            Desc = "Importe les agents existants dans le repo" }
        @{ Key = "stow";   Label = "Stow";               Desc = "Cree/repare le symlink" }
        @{ Key = "unstow"; Label = "Unstow";             Desc = "Supprime le symlink (copie locale)" }
        @{ Key = "quit";   Label = "Quitter";            Desc = "" }
    )

    $selectedIndex = 0
    $done = $false

    # Masquer le curseur
    [Console]::CursorVisible = $false

    while (-not $done) {
        Clear-Host
        Write-Host ""
        Write-Host "================================================" -ForegroundColor Magenta
        Write-Host "       Claude Agents Stow - Windows             " -ForegroundColor Magenta
        Write-Host "================================================" -ForegroundColor Magenta
        Write-Host ""
        Write-Host "  Utilisez fleches haut/bas, Entree pour valider" -ForegroundColor DarkGray
        Write-Host ""

        for ($i = 0; $i -lt $menuItems.Count; $i++) {
            $item = $menuItems[$i]

            if ($i -eq $selectedIndex) {
                Write-Host "  > " -NoNewline -ForegroundColor Cyan
                Write-Host "$($item.Label)" -NoNewline -ForegroundColor White -BackgroundColor DarkBlue
                if ($item.Desc) {
                    Write-Host "  $($item.Desc)" -ForegroundColor DarkGray
                } else {
                    Write-Host ""
                }
            }
            else {
                Write-Host "    $($item.Label)" -NoNewline -ForegroundColor Gray
                if ($item.Desc) {
                    Write-Host "  $($item.Desc)" -ForegroundColor DarkGray
                } else {
                    Write-Host ""
                }
            }
        }

        Write-Host ""

        # Afficher un mini-statut en bas
        Show-QuickStatus

        # Lire la touche
        $key = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")

        switch ($key.VirtualKeyCode) {
            38 { # Fleche haut
                $selectedIndex = if ($selectedIndex -eq 0) { $menuItems.Count - 1 } else { $selectedIndex - 1 }
            }
            40 { # Fleche bas
                $selectedIndex = if ($selectedIndex -eq $menuItems.Count - 1) { 0 } else { $selectedIndex + 1 }
            }
            13 { # Entree
                $done = $true
            }
            27 { # Echap
                $selectedIndex = $menuItems.Count - 1  # Quitter
                $done = $true
            }
        }
    }

    # Reafficher le curseur
    [Console]::CursorVisible = $true

    return $menuItems[$selectedIndex].Key
}

function Show-QuickStatus {
    Write-Host "------------------------------------------------" -ForegroundColor DarkGray

    # Repo status
    $repoOk = Test-Path (Join-Path $Config.DotfilesDir ".git")
    if ($repoOk) {
        Write-Host "  Repo: " -NoNewline -ForegroundColor DarkGray
        Write-Host "[OK]" -NoNewline -ForegroundColor Green
        Write-Host " dotfiles" -ForegroundColor DarkGray
    }
    else {
        Write-Host "  Repo: " -NoNewline -ForegroundColor DarkGray
        Write-Host "[X]" -NoNewline -ForegroundColor Red
        Write-Host " non initialise" -ForegroundColor DarkGray
    }

    # Symlink status
    if (Test-Path $Config.SymlinkPath) {
        if (Test-IsSymlink $Config.SymlinkPath) {
            $target = Get-SymlinkTarget $Config.SymlinkPath
            if ($target -eq $Config.AgentsRepo) {
                Write-Host "  Symlink: " -NoNewline -ForegroundColor DarkGray
                Write-Host "[OK]" -NoNewline -ForegroundColor Green
                Write-Host " OK" -ForegroundColor DarkGray
            }
            else {
                Write-Host "  Symlink: " -NoNewline -ForegroundColor DarkGray
                Write-Host "[!!]" -NoNewline -ForegroundColor Yellow
                Write-Host " mauvaise cible" -ForegroundColor DarkGray
            }
        }
        else {
            Write-Host "  Symlink: " -NoNewline -ForegroundColor DarkGray
            Write-Host "[!!]" -NoNewline -ForegroundColor Yellow
            Write-Host " dossier reel (adopt?)" -ForegroundColor DarkGray
        }
    }
    else {
        Write-Host "  Symlink: " -NoNewline -ForegroundColor DarkGray
        Write-Host "[X]" -NoNewline -ForegroundColor Red
        Write-Host " inexistant" -ForegroundColor DarkGray
    }

    # Agents count
    $agentsPath = if (Test-IsSymlink $Config.SymlinkPath) { $Config.AgentsRepo } else { $Config.SymlinkPath }
    if (Test-Path $agentsPath) {
        $count = (Get-ChildItem $agentsPath -File -Filter "*.md" -ErrorAction SilentlyContinue).Count
        Write-Host "  Agents: " -NoNewline -ForegroundColor DarkGray
        Write-Host "$count" -ForegroundColor Cyan
    }
}

# ==============================================================================
# Actions
# ==============================================================================

function Invoke-Init {
    Write-Host ""
    Write-Info "Initialisation du stow pour les agents Claude..."
    Write-Host ""

    if (-not (Test-CanSymlink)) {
        Write-Err "Impossible de creer des symlinks."
        Write-Host ""
        Write-Host "Solutions :" -ForegroundColor Yellow
        Write-Host "  1. Activer le mode developpeur :"
        Write-Host "     Parametres -> Systeme -> Pour les developpeurs -> Mode developpeur"
        Write-Host "  2. Ou executer ce script en tant qu'administrateur"
        Write-Host ""
        return $false
    }
    Write-OK "Permissions symlink OK"

    if (Test-Path (Join-Path $Config.DotfilesDir ".git")) {
        Write-Info "Repo dotfiles existant, mise a jour..."
        Push-Location $Config.DotfilesDir

        $currentBranch = git branch --show-current 2>$null
        if ($currentBranch -ne $Config.Branch) {
            Write-Info "Passage a la branche $($Config.Branch)..."
            git fetch origin
            git checkout $Config.Branch 2>$null
            if ($LASTEXITCODE -ne 0) {
                git checkout -b $Config.Branch origin/$Config.Branch 2>$null
                if ($LASTEXITCODE -ne 0) {
                    git checkout -b $Config.Branch
                }
            }
        }

        git pull origin $Config.Branch 2>$null
        Pop-Location
        Write-OK "Repo mis a jour"
    }
    else {
        Write-Info "Clonage du repo dotfiles..."

        $branchExists = git ls-remote --heads $Config.RepoUrl $Config.Branch 2>$null

        if ($branchExists) {
            git clone --branch $Config.Branch $Config.RepoUrl $Config.DotfilesDir
        }
        else {
            Write-Info "Branche '$($Config.Branch)' inexistante, creation..."
            git clone $Config.RepoUrl $Config.DotfilesDir
            Push-Location $Config.DotfilesDir
            git checkout -b $Config.Branch
            git push -u origin $Config.Branch
            Pop-Location
        }

        if ($LASTEXITCODE -ne 0) {
            Write-Err "Echec du clonage"
            return $false
        }
        Write-OK "Repo clone dans $($Config.DotfilesDir)"
    }

    if (-not (Test-Path $Config.AgentsRepo)) {
        New-Item -ItemType Directory -Path $Config.AgentsRepo -Force | Out-Null
        Write-OK "Cree: $($Config.AgentsRepo)"
        "" | Set-Content (Join-Path $Config.AgentsRepo ".gitkeep")
    }

    $stowResult = Invoke-Stow

    if ($stowResult) {
        Write-Host ""
        Write-OK "Initialisation terminee!"
        Write-Host ""
        Write-Host "Structure creee :" -ForegroundColor Cyan
        Write-Host "  ~/dotfiles/.config/claude/  <- agents (repo git)"
        Write-Host "              ^ symlink"
        Write-Host "  ~/.claude/agents/"
        Write-Host ""
    }

    return $stowResult
}

function Invoke-Stow {
    Write-Info "Configuration du symlink..."

    if (-not (Test-Path $Config.ClaudeDir)) {
        New-Item -ItemType Directory -Path $Config.ClaudeDir -Force | Out-Null
    }

    if (Test-Path $Config.SymlinkPath) {
        if (Test-IsSymlink $Config.SymlinkPath) {
            $target = Get-SymlinkTarget $Config.SymlinkPath
            if ($target -eq $Config.AgentsRepo) {
                Write-OK "Symlink deja correct"
                return $true
            }
            else {
                Write-Warn "Symlink pointe vers: $target"
                Write-Info "Recreation du symlink..."
                Remove-Item $Config.SymlinkPath -Force
            }
        }
        else {
            $agentCount = (Get-ChildItem $Config.SymlinkPath -File -Filter "*.md" -ErrorAction SilentlyContinue).Count
            if ($agentCount -gt 0) {
                Write-Warn "Dossier agents existant avec $agentCount agent(s)"
                Write-Host "  -> Utiliser 'Adopter' pour les integrer au repo"
                return $false
            }
            else {
                Remove-Item $Config.SymlinkPath -Recurse -Force
            }
        }
    }

    if (-not (Test-Path $Config.AgentsRepo)) {
        Write-Err "Dossier cible inexistant: $($Config.AgentsRepo)"
        Write-Host "  -> Executer d'abord 'Initialiser'"
        return $false
    }

    try {
        New-Item -ItemType SymbolicLink -Path $Config.SymlinkPath -Target $Config.AgentsRepo -Force | Out-Null
        Write-OK "Symlink cree: agents -> dotfiles\.config\claude"
        return $true
    }
    catch {
        Write-Err "Echec creation symlink: $_"
        return $false
    }
}

function Invoke-Unstow {
    Write-Info "Suppression du symlink..."

    if (-not (Test-Path $Config.SymlinkPath)) {
        Write-Warn "Aucun symlink/dossier trouve"
        return $true
    }

    if (-not (Test-IsSymlink $Config.SymlinkPath)) {
        Write-Warn "$($Config.SymlinkPath) n'est pas un symlink"
        return $false
    }

    $agentFiles = Get-ChildItem $Config.AgentsRepo -File -Filter "*.md"

    Remove-Item $Config.SymlinkPath -Force

    New-Item -ItemType Directory -Path $Config.SymlinkPath -Force | Out-Null
    foreach ($file in $agentFiles) {
        Copy-Item $file.FullName $Config.SymlinkPath
    }

    Write-OK "Symlink supprime, dossier local cree avec $($agentFiles.Count) agent(s)"
    return $true
}

function Invoke-Adopt {
    Write-Info "Adoption des agents existants..."

    if (-not (Test-Path $Config.SymlinkPath)) {
        Write-Warn "Aucun dossier agents trouve"
        return $false
    }

    if (Test-IsSymlink $Config.SymlinkPath) {
        Write-Info "Deja un symlink, rien a adopter"
        return $true
    }

    $existingAgents = Get-ChildItem $Config.SymlinkPath -File -Filter "*.md"

    if ($existingAgents.Count -eq 0) {
        Write-Warn "Aucun agent (.md) trouve a adopter"
        return $false
    }

    Write-Info "Agents trouves: $($existingAgents.Count)"
    foreach ($agent in $existingAgents) {
        Write-Host "    - $($agent.Name)" -ForegroundColor Gray
    }

    if (-not (Test-Path $Config.AgentsRepo)) {
        New-Item -ItemType Directory -Path $Config.AgentsRepo -Force | Out-Null
    }

    foreach ($agent in $existingAgents) {
        Copy-Item $agent.FullName $Config.AgentsRepo -Force
        Write-OK "Copie: $($agent.Name)"
    }

    Remove-Item $Config.SymlinkPath -Recurse -Force

    Invoke-Stow

    Write-Host ""
    Write-Info "Pense a faire un Push pour envoyer vers GitHub!"
    Write-Host ""

    return $true
}

function Invoke-Pull {
    Write-Info "Recuperation des changements depuis GitHub..."

    if (-not (Test-Path $Config.DotfilesDir)) {
        Write-Err "Repo non initialise. Utiliser 'Initialiser' d'abord."
        return $false
    }

    Push-Location $Config.DotfilesDir

    git fetch origin $Config.Branch
    $behind = git rev-list HEAD..origin/$Config.Branch --count 2>$null

    if ($behind -gt 0) {
        git pull origin $Config.Branch
        Write-OK "Recupere $behind commit(s)"
    }
    else {
        Write-OK "Deja a jour"
    }

    Pop-Location
    return $true
}

function Invoke-Push {
    Write-Info "Envoi des modifications vers GitHub..."

    if (-not (Test-Path $Config.DotfilesDir)) {
        Write-Err "Repo non initialise. Utiliser 'Initialiser' d'abord."
        return $false
    }

    Push-Location $Config.DotfilesDir

    $status = git status --porcelain ".config/claude"

    if (-not $status) {
        Write-OK "Aucun changement a envoyer"
        Pop-Location
        return $true
    }

    Write-Info "Changements detectes :"
    git status --short ".config/claude"
    Write-Host ""

    # Demander le message de commit
    Write-Host "Message de commit " -NoNewline -ForegroundColor Cyan
    Write-Host "(Entree = 'Update claude agents'): " -NoNewline -ForegroundColor DarkGray
    $commitMsg = Read-Host
    if ([string]::IsNullOrWhiteSpace($commitMsg)) {
        $commitMsg = "Update claude agents"
    }

    git add ".config/claude"
    git commit -m $commitMsg
    git push origin $Config.Branch

    if ($LASTEXITCODE -eq 0) {
        Write-OK "Modifications envoyees!"
    }
    else {
        Write-Err "Echec du push"
    }

    Pop-Location
    return ($LASTEXITCODE -eq 0)
}

function Get-SyncStatus {
    Write-Host ""
    Write-Host "================================================" -ForegroundColor Cyan
    Write-Host "        Claude Agents Stow - Status             " -ForegroundColor Cyan
    Write-Host "================================================" -ForegroundColor Cyan
    Write-Host ""

    Write-Host "Repo dotfiles" -ForegroundColor White
    if (Test-Path $Config.DotfilesDir) {
        Write-OK "Present: $($Config.DotfilesDir)"

        Push-Location $Config.DotfilesDir
        $branch = git branch --show-current 2>$null
        Write-Host "    Branche: $branch"

        git fetch origin $Config.Branch 2>$null
        $behind = git rev-list HEAD..origin/$Config.Branch --count 2>$null
        $ahead = git rev-list origin/$Config.Branch..HEAD --count 2>$null

        if ($behind -gt 0) { Write-Warn "  $behind commit(s) en retard -> Pull" }
        if ($ahead -gt 0) { Write-Info "  $ahead commit(s) en avance -> Push" }
        if ($behind -eq 0 -and $ahead -eq 0) { Write-OK "  Synchronise avec GitHub" }

        Pop-Location
    }
    else {
        Write-Err "Non initialise"
        Write-Host "    -> Utiliser 'Initialiser'"
    }
    Write-Host ""

    Write-Host "Symlink" -ForegroundColor White
    if (Test-Path $Config.SymlinkPath) {
        if (Test-IsSymlink $Config.SymlinkPath) {
            $target = Get-SymlinkTarget $Config.SymlinkPath
            if ($target -eq $Config.AgentsRepo) {
                Write-OK "Correct: ~/.claude/agents -> ~/dotfiles/.config/claude"
            }
            else {
                Write-Warn "Pointe vers: $target"
            }
        }
        else {
            Write-Warn "Dossier reel (pas un symlink)"
            Write-Host "    -> Utiliser 'Adopter'"
        }
    }
    else {
        Write-Err "Inexistant"
        Write-Host "    -> Utiliser 'Stow'"
    }
    Write-Host ""

    Write-Host "Agents" -ForegroundColor White
    $agentsPath = if (Test-IsSymlink $Config.SymlinkPath) { $Config.AgentsRepo } else { $Config.SymlinkPath }

    if (Test-Path $agentsPath) {
        $agents = Get-ChildItem $agentsPath -File -Filter "*.md" -ErrorAction SilentlyContinue
        if ($agents.Count -gt 0) {
            Write-OK "$($agents.Count) agent(s) :"
            foreach ($agent in $agents) {
                Write-Host "    - $($agent.BaseName)" -ForegroundColor Gray
            }
        }
        else {
            Write-Warn "Aucun agent"
        }
    }
    else {
        Write-Err "Dossier agents introuvable"
    }

    Write-Host ""
}

# ==============================================================================
# Main
# ==============================================================================

function Main {
    # Verifier Git
    try { $null = git --version }
    catch {
        Write-Host ""
        Write-Err "Git n'est pas installe"
        return
    }

    # Si action specifiee en parametre, l'executer directement
    if ($Action -ne 'menu') {
        Write-Host ""
        Write-Host "================================================" -ForegroundColor Magenta
        Write-Host "       Claude Agents Stow - Windows             " -ForegroundColor Magenta
        Write-Host "================================================" -ForegroundColor Magenta

        switch ($Action) {
            'init'   { Invoke-Init }
            'stow'   { Invoke-Stow }
            'unstow' { Invoke-Unstow }
            'adopt'  { Invoke-Adopt }
            'pull'   { Invoke-Pull }
            'push'   { Invoke-Push }
            'status' { Get-SyncStatus }
        }
        Write-Host ""
        return
    }

    # Sinon, afficher le menu interactif
    $selectedAction = Show-Menu

    if ($selectedAction -eq 'quit') {
        Write-Host ""
        Write-Host "A bientot!" -ForegroundColor Cyan
        Write-Host ""
        return
    }

    Clear-Host
    Write-Host ""
    Write-Host "================================================" -ForegroundColor Magenta
    Write-Host "       Claude Agents Stow - Windows             " -ForegroundColor Magenta
    Write-Host "================================================" -ForegroundColor Magenta

    switch ($selectedAction) {
        'init'   { Invoke-Init }
        'stow'   { Invoke-Stow }
        'unstow' { Invoke-Unstow }
        'adopt'  { Invoke-Adopt }
        'pull'   { Invoke-Pull }
        'push'   { Invoke-Push }
        'status' { Get-SyncStatus }
    }

    Write-Host ""
    Write-Host "Appuie sur une touche pour revenir au menu..." -ForegroundColor DarkGray
    $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")

    # Relancer le menu
    Main
}

Main
