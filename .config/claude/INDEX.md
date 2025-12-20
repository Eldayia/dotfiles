# Index des Agents Claude

Navigation rapide vers tous les agents et leur documentation.

## 📚 Documentation

| Fichier | Description |
|---------|-------------|
| [README.md](README.md) | Documentation complète et guide d'utilisation |
| [QUICK_REFERENCE.md](QUICK_REFERENCE.md) | Guide de référence rapide - Quel agent utiliser ? |
| [CHANGELOG_AGENTS.md](CHANGELOG_AGENTS.md) | Historique des modifications |
| [INDEX.md](INDEX.md) | Ce fichier - Navigation |

## 🤖 Agents par Catégorie

### Development & Code Quality

| Agent | Description | Proactif | Langages |
|-------|-------------|----------|----------|
| [agent-architect](agent-architect.md) | Conception d'agents AI autonomes | ❌ | - |
| [android-build](android-build.md) | Expert build Gradle Android | ❌ | Gradle, Kotlin |
| [android-code](android-code.md) | Expert Android Kotlin (Compose, MVVM) | ❌ | Kotlin |
| [code-reviewer](code-reviewer.md) | Review multi-langage | ✅ | Multi |
| [code-viewer](code-viewer.md) | Visualisation code Android | ❌ | Kotlin, Java |
| [kotlin](kotlin.md) | Développeur Android/Kotlin élite | ❌ | Kotlin |
| [windows-scripting](windows-scripting.md) | Expert Batch/PowerShell | ❌ | Batch, PowerShell |

### Android Specialists

| Agent | Description | Proactif | Technologies |
|-------|-------------|----------|--------------|
| [compose-navigation](compose-navigation.md) | Navigation Jetpack Compose | ❌ | Compose, Navigation |
| [github-api](github-api.md) | API GitHub REST/GraphQL | ❌ | Retrofit, Apollo |
| [git-operations](git-operations.md) | Git natif Android (JGit) | ❌ | JGit |
| [material-you-design](material-you-design.md) | Material Design 3 | ❌ | Compose, M3 |
| [notifications-handler](notifications-handler.md) | Notifications GitHub | ❌ | FCM, WorkManager |
| [offline-sync](offline-sync.md) | Architecture offline-first | ❌ | Room, WorkManager |

### Architecture & Design

| Agent | Description | Proactif | Focus |
|-------|-------------|----------|-------|
| [agent-architect](agent-architect.md) | Design d'agents | ❌ | AI Agents |
| [project-todolist](project-todolist.md) | Analyse projet et roadmap | ❌ | Planning |

### Documentation & Web

| Agent | Description | Proactif | Formats |
|-------|-------------|----------|---------|
| [doc-writer](doc-writer.md) | Documentation technique | ✅ | Markdown |
| [web-design](web-design.md) | Design web moderne | ✅ | HTML, CSS, JS |

### Tools & Utilities

| Agent | Description | Proactif | Outils |
|-------|-------------|----------|--------|
| [docker-compose-helper](docker-compose-helper.md) | Docker Compose | ✅ | Docker |
| [git-helper](git-helper.md) | Git workflows | ✅ | Git |
| [nix-flake](nix-flake.md) | Nix/NixOS | ✅ | Nix |
| [security-auditor](security-auditor.md) | Audit sécurité | ✅ | OWASP |

### Creative & Assets

| Agent | Description | Proactif | Domaine |
|-------|-------------|----------|---------|
| [eagle-maker](eagle-maker.md) | Assets RPG Maker MZ | ❌ | Game Dev |
| [image-logo-generator](image-logo-generator.md) | Création visuels | ❌ | Design |

## 📊 Statistiques

- **Total agents** : 22
- **Agents proactifs** : 7 (32%)
- **Focus Android** : 12 agents (55%)
- **Dernière mise à jour** : 2025-12-20

## 🎯 Accès Rapide par Besoin

### Android Development
[android-code](android-code.md) • [kotlin](kotlin.md) • [android-build](android-build.md) • [compose-navigation](compose-navigation.md) • [material-you-design](material-you-design.md)

### GitHub Integration
[github-api](github-api.md) • [git-operations](git-operations.md) • [notifications-handler](notifications-handler.md)

### Documentation
[doc-writer](doc-writer.md) • [project-todolist](project-todolist.md)

### Design
[web-design](web-design.md) • [material-you-design](material-you-design.md) • [image-logo-generator](image-logo-generator.md)

### DevOps & Tools
[docker-compose-helper](docker-compose-helper.md) • [nix-flake](nix-flake.md) • [windows-scripting](windows-scripting.md)

### Code Quality
[code-reviewer](code-reviewer.md) • [security-auditor](security-auditor.md)

### Git & Version Control
[git-helper](git-helper.md) • [git-operations](git-operations.md)

## 🔍 Recherche par Mot-clé

### Compose
- [android-code](android-code.md)
- [compose-navigation](compose-navigation.md)
- [material-you-design](material-you-design.md)

### API
- [github-api](github-api.md)

### Database
- [offline-sync](offline-sync.md)

### Notifications
- [notifications-handler](notifications-handler.md)

### Build
- [android-build](android-build.md)

### Navigation
- [compose-navigation](compose-navigation.md)

### Design
- [material-you-design](material-you-design.md)
- [web-design](web-design.md)
- [image-logo-generator](image-logo-generator.md)

### Security
- [security-auditor](security-auditor.md)

### Testing
- [code-reviewer](code-reviewer.md)

## 📦 Installation

Tous les agents sont disponibles via le système de stow :

```powershell
# Installer les symlinks
.\scripts\stow-claude-agents.ps1 stow

# Vérifier le statut
.\scripts\stow-claude-agents.ps1 status
```

## 🚀 Démarrage Rapide

1. **Nouveau sur Android ?**
   → Commencer avec [android-code](android-code.md)

2. **Besoin d'aide design ?**
   → [material-you-design](material-you-design.md) ou [web-design](web-design.md)

3. **Créer un script Windows ?**
   → [windows-scripting](windows-scripting.md)

4. **Review de code ?**
   → [code-reviewer](code-reviewer.md)

5. **Documentation ?**
   → [doc-writer](doc-writer.md)

6. **Nouveau agent ?**
   → [agent-architect](agent-architect.md)

## 📖 Guides Recommandés

### Pour Débutants
1. Lire [QUICK_REFERENCE.md](QUICK_REFERENCE.md)
2. Identifier votre besoin
3. Choisir l'agent approprié
4. Consulter la doc de l'agent

### Pour Développeurs Android
1. [android-code](android-code.md) - Développement général
2. [compose-navigation](compose-navigation.md) - Navigation
3. [material-you-design](material-you-design.md) - Design
4. [offline-sync](offline-sync.md) - Cache et sync
5. [code-reviewer](code-reviewer.md) - Qualité

### Pour Créateurs d'Agents
1. [agent-architect](agent-architect.md) - Design d'agents
2. Étudier les agents existants
3. Suivre les conventions établies
4. Documenter complètement

## 🔗 Liens Utiles

- [Documentation Principale](../../../CLAUDE.md)
- [Repository Dotfiles](../../../README.md)
- [Script Stow](../../../scripts/stow-claude-agents.ps1)
- [Claude Code Docs](https://docs.claude.ai/code)

## 📝 Notes

- Les agents marqués ✅ **Proactif** s'activent automatiquement dans certains contextes
- Tous les agents supportent le français et l'anglais
- Les agents Android sont optimisés pour le développement moderne (Compose, Kotlin, M3)
- Documentation mise à jour régulièrement

---

**Dernière mise à jour** : 2025-12-20
**Version** : 1.0.0
**Agents** : 22
