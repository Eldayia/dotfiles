# Changelog

Toutes les modifications notables de ce projet sont documentées dans ce fichier.

Le format est basé sur [Keep a Changelog](https://keepachangelog.com/fr/1.0.0/),
et ce projet adhère à [Semantic Versioning](https://semver.org/lang/fr/).

## [Non publié]

### Ajouté
- **Android Studio** avec ses dépendances complètes (SDK, Platform Tools, Emulator, Gradle)
- **OpenJDK 21** pour le développement Java
- **.NET SDK 8** pour le développement C#
- **LLVM/Clang** pour la compilation C++
- **MinGW-w64** (téléchargement manuel) pour GCC sur Windows
- **Outils npm** post-installation : TypeScript, Vite, Vue CLI, ESLint, Prettier
- Section "Post-installation" dans la documentation pour les outils npm
- Support complet pour tous les langages : C++, C#, Python, Rust, Java, JavaScript/TypeScript
- Documentation détaillée des nouveaux outils dans README.md et README_MODULES.md
- Détails sur l'environnement de développement complet dans CLAUDE.md

### Modifié
- **Revo Uninstaller Pro** n'est plus limité au PC Desktop, s'installe désormais sur tous les PC (Desktop et Laptop)
- Réorganisation de la section "Développement" dans README.md avec catégorisation par type d'outil
- Réorganisation de la section "Outils système" dans README.md avec sous-catégories
- Mise à jour du nombre total de logiciels : 67+ → 75+
- Amélioration de la section "Nouveautés récentes" avec détails sur l'environnement de développement
- Enrichissement de la documentation technique dans README_MODULES.md

### Documentation
- Ajout d'exemples d'utilisation pour l'installation d'un poste de développement complet
- Documentation des langages et frameworks supportés
- Instructions détaillées pour la post-installation npm
- Clarification du comportement Desktop vs Laptop pour Revo Uninstaller Pro

## [1.0.0] - 2024-12

### Ajouté
- Architecture modulaire inspirée de NixOS
- 8 modules spécialisés par catégorie
- Fonctions réutilisables dans `common/functions.bat`
- Mode Desktop vs Laptop avec installation adaptative
- Documentation complète (README.md, README_MODULES.md, CLAUDE.md)
- Support de 67+ logiciels via Winget
- Système de fallback curl si winget échoue
- Script de gestion des agents Claude (`scripts/stow-claude-agents.ps1`)

### Modifié
- Refactorisation complète du script monolithique en modules
- Passage de 1 fichier de 401 lignes à 10+ fichiers organisés

### Supprimer
- Ancien script monolithique (conservé en backup : `downloadSoftware.bat.old`)
