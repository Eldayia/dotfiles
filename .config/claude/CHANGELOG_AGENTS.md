# Changelog - Claude Agents

Historique des modifications apportées aux agents Claude.

Le format suit [Keep a Changelog](https://keepachangelog.com/fr/1.0.0/).

## [Non publié]

### Documentation
- Ajout de `README.md` - Documentation complète des 22 agents
- Ajout de `QUICK_REFERENCE.md` - Guide de référence rapide
- Ajout de `CHANGELOG_AGENTS.md` - Suivi des modifications
- Mise à jour de `CLAUDE.md` - Section "Claude Agents Available"

## [2025-12-20] - Documentation initiale

### Agents Disponibles

#### Development & Code Quality (6 agents)
- `agent-architect.md` - Conception d'agents AI autonomes
- `android-build.md` - Expert build Gradle Android
- `android-code.md` - Expert Android Kotlin (Compose, MVVM)
- `code-reviewer.md` - Review multi-langage
- `code-viewer.md` - Visualisation code Android
- `kotlin.md` - Développeur Android/Kotlin élite
- `windows-scripting.md` - Expert Batch/PowerShell

#### Android Specialists (6 agents)
- `compose-navigation.md` - Navigation Jetpack Compose
- `github-api.md` - API GitHub REST/GraphQL
- `git-operations.md` - Git natif Android (JGit)
- `material-you-design.md` - Material Design 3
- `notifications-handler.md` - Notifications GitHub
- `offline-sync.md` - Architecture offline-first

#### Architecture & Design (2 agents)
- `agent-architect.md` - Design d'agents
- `project-todolist.md` - Analyse projet et roadmap

#### Documentation & Web (2 agents)
- `doc-writer.md` - Documentation technique
- `web-design.md` - Design web moderne

#### Tools & Utilities (4 agents)
- `docker-compose-helper.md` - Docker Compose
- `git-helper.md` - Git workflows
- `nix-flake.md` - Nix/NixOS
- `security-auditor.md` - Audit sécurité

#### Creative & Assets (2 agents)
- `eagle-maker.md` - Assets RPG Maker MZ
- `image-logo-generator.md` - Création visuels

### Statistiques
- **Total** : 22 agents spécialisés
- **Focus Android** : 12 agents (55%)
- **Agents proactifs** : 7 agents
- **Dernière mise à jour** : 2025-12-20

## Historique des Commits Récents

### 2025-12-19
- `eagle-maker.md` - Création agent RPG Maker MZ
- `image-logo-generator.md` - Création agent génération assets

### 2025-12-18
- Ajout de 12 agents Android spécialisés
- `android-build.md`
- `code-viewer.md`
- `compose-navigation.md`
- `github-api.md`
- `git-operations.md`
- `material-you-design.md`
- `notifications-handler.md`
- `offline-sync.md`
- `project-todolist.md`
- `windows-scripting.md`

### 2025-12-17
- `android-code.md` - Expert Android initial
- `code-reviewer.md` - Review de code
- `docker-compose-helper.md`
- `doc-writer.md`
- `git-helper.md`
- `kotlin.md` - Développeur Kotlin
- `nix-flake.md`
- `security-auditor.md`
- `web-design.md`

## Améliorations Prévues

### Agents à Créer
- [ ] `firebase-integration` - Firebase pour Android (Auth, Firestore, Analytics)
- [ ] `testing-expert` - Tests Android (JUnit, Espresso, Compose Testing)
- [ ] `cicd-helper` - CI/CD Android (GitHub Actions, GitLab CI)
- [ ] `performance-optimizer` - Performance Android (Profiler, LeakCanary)
- [ ] `database-expert` - Room migrations, queries complexes
- [ ] `rust-developer` - Développement Rust
- [ ] `python-expert` - Python/FastAPI
- [ ] `devops-engineer` - Infrastructure, déploiement

### Agents à Améliorer
- [ ] `android-code` - Ajouter exemples Compose avancés
- [ ] `github-api` - Ajouter webhooks et GitHub Apps
- [ ] `windows-scripting` - Ajouter exemples WMI/CIM
- [ ] `web-design` - Ajouter frameworks modernes (Astro, SolidJS)
- [ ] `doc-writer` - Templates ADR (Architecture Decision Records)

### Documentation
- [ ] Vidéos tutoriels d'utilisation
- [ ] Exemples d'intégration multi-agents
- [ ] Benchmarks de performance
- [ ] Guide de contribution

## Notes de Version

### Version Actuelle : 1.0.0
- Collection initiale de 22 agents
- Focus sur développement Android
- Support Windows scripting
- Documentation complète

### Compatibilité
- Claude Code : ✅ Testé
- Claude.ai : ✅ Compatible
- API Claude : ✅ Compatible (via Task tool)

## Contributions

Les contributions sont bienvenues ! Pour ajouter ou modifier un agent :

1. Créer/modifier le fichier dans `.config/claude/`
2. Tester avec Claude Code
3. Mettre à jour ce CHANGELOG
4. Mettre à jour README.md si nécessaire
5. Commit avec message conventionnel :
   ```
   feat(claude): ajout agent [nom] pour [purpose]
   fix(claude): correction agent [nom] - [description]
   docs(claude): mise à jour documentation agents
   ```

## Maintenance

### Dernière revue
- **Date** : 2025-12-20
- **Agents vérifiés** : 22/22
- **Issues ouvertes** : 0
- **Documentation** : ✅ À jour

### Prochaine revue prévue
- **Date** : 2026-01-20
- **Focus** : Feedback utilisateurs, nouveaux besoins

## Ressources

- [Claude Code Documentation](https://docs.claude.ai/code)
- [Repository Dotfiles](../../../README.md)
- [Script Stow](../../../scripts/stow-claude-agents.ps1)
