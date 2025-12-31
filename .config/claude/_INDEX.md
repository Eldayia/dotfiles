# Index des Agents Claude

Navigation rapide vers tous les agents.

## 🚀 Agents Hub (Consolidés)

Ces agents regroupent plusieurs expertises en un seul point d'entrée.

| Agent | Description | Anciens agents fusionnés |
|-------|-------------|-------------------------|
| [DEV_Android](DEV_Android.md) | Développement Android complet | android-code, android-build, kotlin, compose-navigation, material-you-design, github-api, git-operations, notifications-handler, offline-sync, code-viewer |
| [DEV_GH](DEV_GH.md) | Git workflows & Conventional Commits | git-helper |
| [DEV_Quality](DEV_Quality.md) | Code review & Security audit | code-reviewer, security-auditor |
| [DEV_Doc](DEV_Doc.md) | Documentation technique | doc-writer |
| [INFRA](INFRA.md) | Docker, Nix, Windows scripting | docker-compose-helper, nix-flake, windows-scripting |
| [DESIGN](DESIGN.md) | Design web & Assets visuels | web-design, image-logo-generator |
| [RPG](RPG.md) | RPG Maker MZ & Eagle | eagle-maker |
| [META](META.md) | Conception d'agents & Roadmap | agent-architect, project-todolist |

## 🎯 Guide rapide : Quel agent utiliser ?

| Besoin | Agent | Mode |
|--------|-------|------|
| Développer une feature Android | DEV_Android | `mode: code` |
| Problème de build Gradle | DEV_Android | `mode: build` |
| Navigation Compose | DEV_Android | `mode: navigation` |
| Design Material You | DEV_Android | `mode: design` |
| Intégrer API GitHub | DEV_Android | `mode: github-api` |
| Git natif sur Android (JGit) | DEV_Android | `mode: git-ops` |
| Notifications Android | DEV_Android | `mode: notifications` |
| Architecture offline-first | DEV_Android | `mode: offline` |
| Visualisation de code | DEV_Android | `mode: code-viewer` |
| Message de commit | DEV_GH | — |
| Rebase/merge/conflits | DEV_GH | — |
| Review de code | DEV_Quality | `mode: review` |
| Audit sécurité | DEV_Quality | `mode: security` |
| Écrire un README | DEV_Doc | — |
| Docker Compose | INFRA | `mode: docker` |
| Nix flake | INFRA | `mode: nix` |
| Script PowerShell/Batch | INFRA | `mode: windows` |
| Audit design web | DESIGN | `mode: web` |
| Créer un logo | DESIGN | `mode: assets` |
| Organiser assets RPG Maker | RPG | — |
| Créer un nouvel agent | META | `mode: architect` |
| Analyser projet & roadmap | META | `mode: todolist` |

## 📦 Installation

```powershell
# Installer les symlinks
.\scripts\stow-claude-agents.ps1 stow

# Vérifier le statut
.\scripts\stow-claude-agents.ps1 status
```

## 📚 Documentation

| Fichier | Description |
|---------|-------------|
| [_README.md](_README.md) | Documentation complète |
| [_QUICK_REFERENCE.md](_QUICK_REFERENCE.md) | Référence rapide |
| [_CHANGELOG_AGENTS.md](_CHANGELOG_AGENTS.md) | Historique des modifications |

## 📊 Statistiques

- **Agents hub** : 8
- **Dernière mise à jour** : 2025-12-26

---

## 🗄️ Anciens agents (conservés pour référence)

Les anciens agents individuels sont toujours disponibles mais il est recommandé d'utiliser les agents hub consolidés.

<details>
<summary>Voir les anciens agents</summary>

| Agent | Remplacé par |
|-------|--------------|
| android-code | DEV_Android (mode: code) |
| android-build | DEV_Android (mode: build) |
| kotlin | DEV_Android (mode: architecture) |
| compose-navigation | DEV_Android (mode: navigation) |
| material-you-design | DEV_Android (mode: design) |
| github-api | DEV_Android (mode: github-api) |
| git-operations | DEV_Android (mode: git-ops) |
| notifications-handler | DEV_Android (mode: notifications) |
| offline-sync | DEV_Android (mode: offline) |
| code-viewer | DEV_Android (mode: code-viewer) |
| git-helper | DEV_GH |
| code-reviewer | DEV_Quality (mode: review) |
| security-auditor | DEV_Quality (mode: security) |
| doc-writer | DEV_Doc |
| docker-compose-helper | INFRA (mode: docker) |
| nix-flake | INFRA (mode: nix) |
| windows-scripting | INFRA (mode: windows) |
| web-design | DESIGN (mode: web) |
| image-logo-generator | DESIGN (mode: assets) |
| eagle-maker | RPG |
| agent-architect | META (mode: architect) |
| project-todolist | META (mode: todolist) |

</details>
