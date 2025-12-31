# Changelog - Claude Agents

Historique des modifications apportées aux agents Claude.

Le format suit [Keep a Changelog](https://keepachangelog.com/fr/1.0.0/).

## [Non publié]

## [2025-12-26] - Consolidation en Agents Hub

### Added
- `DEV_Android.md` - Agent hub Android consolidé (10 modes)
- `DEV_GH.md` - Agent hub Git & Conventional Commits
- `DEV_Quality.md` - Agent hub Code Review & Security
- `DEV_Doc.md` - Agent hub Documentation
- `INFRA.md` - Agent hub Infrastructure (Docker, Nix, Windows)
- `DESIGN.md` - Agent hub Design (Web, Assets)
- `RPG.md` - Agent hub RPG Maker MZ
- `META.md` - Agent hub Méta-agents (Architect, Todolist)

### Changed
- `_INDEX.md` - Nouvelle structure avec agents hub
- Architecture: 22 agents → 8 agents hub consolidés

### Deprecated
Les anciens agents individuels restent disponibles mais sont remplacés par les agents hub :

| Ancien agent | Nouveau hub |
|--------------|-------------|
| android-code, android-build, kotlin, compose-navigation, material-you-design, github-api, git-operations, notifications-handler, offline-sync, code-viewer | DEV_Android |
| git-helper | DEV_GH |
| code-reviewer, security-auditor | DEV_Quality |
| doc-writer | DEV_Doc |
| docker-compose-helper, nix-flake, windows-scripting | INFRA |
| web-design, image-logo-generator | DESIGN |
| eagle-maker | RPG |
| agent-architect, project-todolist | META |

### Rationale
- **Navigation simplifiée** : 8 points d'entrée au lieu de 22
- **Modes intégrés** : Préfixe `mode: X` pour choisir l'expertise
- **Contexte partagé** : Chaque hub connaît ses domaines connexes
- **Moins de friction** : Pas besoin de se rappeler quel agent utiliser

---

## [2025-12-20] - Documentation initiale

### Added
- `README.md` - Documentation complète des 22 agents
- `QUICK_REFERENCE.md` - Guide de référence rapide
- `CHANGELOG_AGENTS.md` - Suivi des modifications
- Mise à jour de `CLAUDE.md` - Section "Claude Agents Available"

### Agents Disponibles (22 agents)

#### Development & Code Quality
- `agent-architect.md` - Conception d'agents AI autonomes
- `android-build.md` - Expert build Gradle Android
- `android-code.md` - Expert Android Kotlin (Compose, MVVM)
- `code-reviewer.md` - Review multi-langage
- `code-viewer.md` - Visualisation code Android
- `kotlin.md` - Développeur Android/Kotlin élite
- `windows-scripting.md` - Expert Batch/PowerShell

#### Android Specialists
- `compose-navigation.md` - Navigation Jetpack Compose
- `github-api.md` - API GitHub REST/GraphQL
- `git-operations.md` - Git natif Android (JGit)
- `material-you-design.md` - Material Design 3
- `notifications-handler.md` - Notifications GitHub
- `offline-sync.md` - Architecture offline-first

#### Architecture & Design
- `project-todolist.md` - Analyse projet et roadmap

#### Documentation & Web
- `doc-writer.md` - Documentation technique
- `web-design.md` - Design web moderne

#### Tools & Utilities
- `docker-compose-helper.md` - Docker Compose
- `git-helper.md` - Git workflows
- `nix-flake.md` - Nix/NixOS
- `security-auditor.md` - Audit sécurité

#### Creative & Assets
- `eagle-maker.md` - Assets RPG Maker MZ
- `image-logo-generator.md` - Création visuels

---

## Statistiques

### Version actuelle (2025-12-26)
- **Agents hub** : 8
- **Focus principal** : Développement Android
- **Documentation** : ✅ À jour

### Version précédente (2025-12-20)
- **Agents individuels** : 22
- **Focus Android** : 12 agents (55%)
- **Agents proactifs** : 7 agents

---

## Améliorations Prévues

### À créer
- [ ] Agent hub `MOBILE` (si iOS ajouté)
- [ ] Agent hub `BACKEND` (Rust, Python, Node)
- [ ] Agent hub `TESTING` (Tests Android, CI/CD)

### À améliorer
- [ ] DEV_Android - Ajouter mode `testing`
- [ ] INFRA - Ajouter mode `kubernetes`
- [ ] META - Templates d'agents prédéfinis

---

## Contributions

Pour modifier un agent :

1. Éditer le fichier `.md` correspondant
2. Tester avec Claude Code
3. Mettre à jour ce CHANGELOG
4. Commit avec message conventionnel :
   ```
   feat(claude): [description]
   fix(claude): [description]
   docs(claude): [description]
   ```
