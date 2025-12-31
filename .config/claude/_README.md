# Claude Agents Collection

Collection de 22 agents spécialisés pour Claude Code, optimisés pour le développement Android, le scripting Windows, et diverses tâches de développement.

## Installation

Utilisez le script `stow-claude-agents.ps1` pour créer un symlink vers ces agents :

```powershell
.\scripts\stow-claude-agents.ps1 stow
```

Les agents seront disponibles dans `~/.claude/agents/`.

## Catégories d'Agents

### 🤖 Development & Code Quality

#### android-code
Expert Android Kotlin senior spécialisé en développement moderne.
- **Compétences** : Kotlin, Jetpack Compose, MVVM, Clean Architecture
- **Usage** : Création de projets, implémentation de features, review de code
- **Outils** : Coroutines, Flow, Hilt/Dagger, Room, Retrofit

#### android-build
Expert système de build Android avec Gradle.
- **Compétences** : Compilation, nettoyage, résolution d'erreurs
- **Usage** : Problèmes de build, optimisation des performances Gradle
- **Commandes** : `assembleDebug`, `clean`, `dependencies`, `lint`

#### kotlin
Développeur Android/Kotlin élite avec architecture avancée.
- **Compétences** : Architecture patterns, performance, sécurité
- **Usage** : Projets complexes, refactoring, optimisation
- **Focus** : Production-ready code, maintenabilité

#### code-reviewer
Review de code multi-langage.
- **Checklist** : Correctness, lisibilité, maintenabilité, performance, sécurité
- **Usage** : PROACTIF avant commits importants
- **Format** : Résumé, points positifs, suggestions, corrections

#### code-viewer
Visualisation de code sur Android.
- **Compétences** : Syntax highlighting, Markdown rendering, file tree navigation
- **Usage** : Affichage de code, diff viewer
- **Bibliothèques** : CodeView, Markwon, custom Compose solutions

#### windows-scripting
Expert Batch et PowerShell pour Windows.
- **Compétences** : Automation, installation, configuration système
- **Usage** : Scripts d'installation, gestion du registre, tâches planifiées
- **Outils** : Winget, Chocolatey, schtasks, symlinks

### 📱 Android-Specific Specialists

#### compose-navigation
Navigation Jetpack Compose type-safe.
- **Compétences** : Routes Serializable, deep links, animations
- **Usage** : Architecture de navigation, multi-module, bottom nav
- **Patterns** : Type-safe navigation, shared elements, predictive back

#### material-you-design
Material Design 3 / Material You expert.
- **Compétences** : Dynamic color, composants M3, theming
- **Usage** : Design system, accessibilité, animations Material
- **Composants** : TopAppBar, Cards, FAB, NavigationBar

#### github-api
Intégration API GitHub (REST v3 + GraphQL v4).
- **Compétences** : OAuth, pagination, rate limiting, caching
- **Usage** : Applications GitHub client pour Android
- **Endpoints** : Repos, Issues, PRs, Notifications, Users

#### git-operations
Opérations Git natives sur Android avec JGit.
- **Compétences** : Clone, fetch, pull, push, diff, merge
- **Usage** : Git client Android, visualisation historique
- **Sécurité** : Gestion credentials, EncryptedSharedPreferences

#### notifications-handler
Système de notifications GitHub sur Android.
- **Compétences** : FCM, polling intelligent, canaux, deep linking
- **Usage** : Notifications push, synchronisation état lu/non lu
- **Patterns** : Grouping, actions rapides, filtrage

#### offline-sync
Architecture offline-first pour Android.
- **Compétences** : Room, WorkManager, DataStore, Repository pattern
- **Usage** : Apps avec cache local, sync en arrière-plan
- **Stratégies** : Pull-based, optimistic updates, conflict resolution

### 🏗️ Architecture & Design

#### agent-architect
Conception d'agents AI autonomes.
- **Compétences** : Design d'agents, prompt engineering, multi-agent systems
- **Usage** : Créer de nouveaux agents, améliorer agents existants
- **Méthodologie** : Discovery, architecture, prompt excellence

#### project-todolist
Analyse de projet et génération de roadmap.
- **Compétences** : Audit features, benchmark concurrentiel, priorisation
- **Usage** : Analyser un projet, générer todolist MVP/V1
- **Méthodes** : MoSCoW, Impact vs Effort, User Journey

### 📝 Documentation & Web

#### doc-writer
Expert documentation technique.
- **Compétences** : README, API docs, CHANGELOG, ADR
- **Usage** : PROACTIF lors de création de features
- **Standards** : Keep a Changelog, exemples concrets, structure navigable

#### web-design
Design web moderne et accessibilité.
- **Compétences** : HTML/CSS/JS, WCAG 2.2, responsive design, performance
- **Usage** : PROACTIF sur fichiers frontend
- **Analyse** : Core Web Vitals, accessibilité, design systems

### 🛠️ Tools & Utilities

#### docker-compose-helper
Expert Docker Compose.
- **Compétences** : Debug, optimisation, bonnes pratiques
- **Usage** : PROACTIF sur fichiers docker-compose.yml
- **Vérifications** : Healthchecks, sécurité, persistence, réseaux

#### git-helper
Workflows Git et Conventional Commits.
- **Compétences** : Commits conventionnels, branches, résolution conflits
- **Usage** : PROACTIF avant commits
- **Format** : `<type>(<scope>): <description>`

#### nix-flake
Nix/NixOS flakes et environnements dev.
- **Compétences** : Flakes, derivations, home-manager
- **Usage** : PROACTIF sur fichiers .nix
- **Commandes** : `nix develop`, `nix build`, `nix flake update`

#### security-auditor
Audit de sécurité applicative.
- **Compétences** : OWASP Top 10, secrets, dépendances, configuration
- **Usage** : PROACTIF sur code sensible (auth, API)
- **Checks** : Injection, broken auth, XSS, CVE

### 🎨 Creative & Assets

#### eagle-maker
Organisation d'assets RPG Maker MZ pour Eagle.
- **Compétences** : Structure Eagle, tags, détection doublons
- **Usage** : Import et organisation DLC RPG Maker
- **Mapping** : img/ → Eagle folders, alias DLC

#### image-logo-generator
Création d'assets visuels (logos, icônes, UI).
- **Compétences** : Logo design, app icons, UI illustrations
- **Usage** : Besoin de visuels pour projets
- **Spécialités** : Adaptive Icons Android, Material Design

## Usage des Agents

### Via Claude Code

Les agents sont automatiquement disponibles après installation du symlink. Claude Code peut les utiliser via le Task tool :

```
@agent-name Votre requête ici
```

### Agents Proactifs

Certains agents s'activent automatiquement sur certains types de fichiers :
- **code-reviewer** : Avant commits importants
- **doc-writer** : Création de features
- **docker-compose-helper** : Fichiers `docker-compose.yml`
- **web-design** : Fichiers frontend (CSS, JSX, Vue)
- **security-auditor** : Code sensible (auth, API)
- **git-helper** : Avant commits
- **nix-flake** : Fichiers `.nix`

### Exemple d'Utilisation

```
# Demander à l'agent Android de créer un nouveau screen
@android-code Crée un écran de liste de repositories avec Jetpack Compose

# Review de code avant commit
@code-reviewer Analyse les changements dans le ViewModel

# Génération de documentation
@doc-writer Crée un README pour ce module

# Aide sur la navigation
@compose-navigation Implémente le deep linking pour cette route
```

## Structure des Agents

Chaque agent est défini dans un fichier `.md` avec :
- **name** : Identifiant unique
- **description** : Conditions d'utilisation et exemples
- **model** : Modèle à utiliser (sonnet, opus, etc.)
- **color** : Couleur pour identification visuelle (optionnel)
- **tools** : Outils disponibles pour l'agent (optionnel)

## Développement d'Agents

Pour créer un nouvel agent, utilisez **agent-architect** :

```
@agent-architect Je veux créer un agent pour [description]
```

L'agent-architect vous guidera dans :
1. La définition des requirements
2. L'architecture de l'agent
3. Le prompt engineering
4. La génération du fichier de configuration

## Maintenance

### Mise à jour des Agents

```powershell
# Depuis le repo dotfiles
cd .config/claude
# Modifier les agents

# Synchroniser avec ~/.claude/agents
.\scripts\stow-claude-agents.ps1 push
```

### Sauvegarde

Les agents sont versionés dans le repo dotfiles. Pour les sauvegarder :

```bash
git add .config/claude/
git commit -m "feat(claude): mise à jour des agents"
git push
```

## Agents Spécialisés Android

Pour le développement Android (projet Hubyou par exemple), plusieurs agents travaillent ensemble :

1. **android-code** : Développement principal
2. **kotlin** : Architecture complexe
3. **compose-navigation** : Navigation
4. **material-you-design** : Design system
5. **github-api** : Intégration API
6. **notifications-handler** : Système de notifications
7. **offline-sync** : Cache et sync

## Contribution

Pour ajouter ou améliorer un agent :

1. Créer/modifier le fichier dans `.config/claude/`
2. Tester avec Claude Code
3. Documenter dans ce README
4. Commit et push

## Ressources

- [Claude Code Documentation](https://docs.claude.ai/code)
- [Agent Architecture Best Practices](https://docs.anthropic.com/agents)
- [Dotfiles Repository](https://github.com/yourusername/dotfiles)
