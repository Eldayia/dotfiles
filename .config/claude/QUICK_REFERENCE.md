# Quick Reference - Quel Agent Utiliser ?

Guide rapide pour choisir le bon agent selon votre besoin.

## Par Tâche

### Je développe une app Android
| Besoin | Agent | Quand l'utiliser |
|--------|-------|-----------------|
| Créer un nouveau projet | `android-code` | Setup initial, architecture |
| Ajouter une feature | `android-code` | Implémentation Kotlin/Compose |
| Problème de build | `android-build` | Erreurs Gradle, compilation |
| Navigation entre écrans | `compose-navigation` | Routes, deep links, animations |
| Design Material You | `material-you-design` | Thème, couleurs, composants M3 |
| Intégrer GitHub API | `github-api` | REST/GraphQL, auth, pagination |
| Opérations Git locales | `git-operations` | JGit, clone, commit, merge |
| Notifications push | `notifications-handler` | FCM, polling, canaux |
| Mode offline | `offline-sync` | Room, cache, sync background |
| Afficher du code | `code-viewer` | Syntax highlighting, diff viewer |
| Architecture complexe | `kotlin` | Refactoring, patterns avancés |

### Je code (général)
| Besoin | Agent |
|--------|-------|
| Review de code | `code-reviewer` |
| Audit sécurité | `security-auditor` |

### Je gère Windows
| Besoin | Agent |
|--------|-------|
| Script Batch/PowerShell | `windows-scripting` |
| Installation de logiciels | `windows-scripting` |
| Automation système | `windows-scripting` |

### Je travaille avec Git/GitHub
| Besoin | Agent |
|--------|-------|
| Commits conventionnels | `git-helper` |
| Gestion de branches | `git-helper` |
| API GitHub (web/mobile) | `github-api` |
| Git local sur Android | `git-operations` |

### Je documente
| Besoin | Agent |
|--------|-------|
| README, CHANGELOG | `doc-writer` |
| Documentation API | `doc-writer` |

### Je design
| Besoin | Agent |
|--------|-------|
| Design web moderne | `web-design` |
| Logo, icônes, UI graphics | `image-logo-generator` |
| Material Design 3 | `material-you-design` |

### Je gère des projets
| Besoin | Agent |
|--------|-------|
| Analyser un projet | `project-todolist` |
| Générer une roadmap | `project-todolist` |
| Créer un nouvel agent | `agent-architect` |

### J'utilise des outils spécifiques
| Outil | Agent |
|-------|-------|
| Docker Compose | `docker-compose-helper` |
| Nix/NixOS | `nix-flake` |
| RPG Maker MZ + Eagle | `eagle-maker` |

## Par Langage

| Langage | Agents Recommandés |
|---------|-------------------|
| Kotlin | `kotlin`, `android-code`, `android-build` |
| Batch | `windows-scripting` |
| PowerShell | `windows-scripting` |
| JavaScript/Web | `web-design` |
| Nix | `nix-flake` |

## Par Technologie

| Technologie | Agent |
|-------------|-------|
| Jetpack Compose | `android-code`, `compose-navigation`, `material-you-design` |
| Gradle | `android-build` |
| JGit | `git-operations` |
| GitHub API | `github-api` |
| Room Database | `offline-sync` |
| WorkManager | `offline-sync` |
| Material Design 3 | `material-you-design` |
| Docker | `docker-compose-helper` |

## Agents Proactifs (Auto-activation)

Ces agents s'activent automatiquement dans certains contextes :

| Agent | S'active sur |
|-------|--------------|
| `code-reviewer` | Avant commits importants |
| `doc-writer` | Création de nouvelles features |
| `docker-compose-helper` | Fichiers `docker-compose.yml` |
| `web-design` | Fichiers `.css`, `.jsx`, `.vue`, `.html` |
| `security-auditor` | Code auth, API keys, fichiers sensibles |
| `git-helper` | Avant commits |
| `nix-flake` | Fichiers `.nix`, `flake.nix` |

## Workflow Typique Android

Pour un projet Android comme Hubyou :

```
1. Setup projet       → android-code
2. Architecture       → kotlin (si complexe)
3. UI/Design          → material-you-design
4. Navigation         → compose-navigation
5. API GitHub         → github-api
6. Opérations Git     → git-operations
7. Notifications      → notifications-handler
8. Offline/Cache      → offline-sync
9. Build/Debug        → android-build
10. Review code       → code-reviewer
11. Documentation     → doc-writer
12. Assets visuels    → image-logo-generator
```

## Commandes Rapides

```bash
# Utiliser un agent dans Claude Code
@agent-name Votre requête

# Exemples
@android-code Crée un écran de profil utilisateur
@compose-navigation Ajoute le deep linking pour /repo/:owner/:name
@material-you-design Applique Dynamic Color à ce composant
@github-api Implémente la pagination pour les issues
@code-reviewer Analyse ce ViewModel
@doc-writer Crée le README du module auth
@windows-scripting Script d'installation pour VS Code et Git
```

## Choisir Entre Plusieurs Agents

### android-code vs kotlin
- **android-code** : Feature standard, UI, logique métier simple
- **kotlin** : Architecture complexe, refactoring majeur, optimisation

### github-api vs git-operations
- **github-api** : Interaction avec l'API GitHub (issues, PRs, repos)
- **git-operations** : Git local sur appareil (clone, commit, diff)

### doc-writer vs web-design
- **doc-writer** : Documentation technique (README, API)
- **web-design** : Design visuel, accessibilité, UX/UI

## Par Niveau d'Expertise Requis

### Débutant-Friendly
- `doc-writer`
- `git-helper`
- `docker-compose-helper`

### Intermédiaire
- `android-code`
- `compose-navigation`
- `windows-scripting`
- `web-design`

### Avancé
- `kotlin`
- `android-build`
- `offline-sync`
- `agent-architect`
- `security-auditor`

## Cas d'Usage Réels

### "Je veux créer une app GitHub client Android"
Agents nécessaires :
1. `android-code` - Setup et développement
2. `material-you-design` - Design system
3. `github-api` - Intégration API
4. `compose-navigation` - Navigation
5. `offline-sync` - Cache local
6. `notifications-handler` - Notifications

### "Je fais un script d'installation Windows"
Agent : `windows-scripting`

### "Je dois documenter mon API"
Agent : `doc-writer`

### "J'ai un bug de build Gradle"
Agent : `android-build`

### "Je veux améliorer le design de mon site"
Agent : `web-design`

### "Je crée une nouvelle feature Android"
Séquence :
1. `android-code` - Implémentation
2. `material-you-design` - UI
3. `code-reviewer` - Review
4. `doc-writer` - Documentation
5. `git-helper` - Commit

## Aide Supplémentaire

- **Documentation complète** : `README.md`
- **Créer un nouvel agent** : `@agent-architect`
- **Liste tous les agents** : Voir `.config/claude/`
