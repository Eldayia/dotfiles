# CLAUDE.md

Ce fichier fournit des directives à WARP (warp.dev) et Claude lors du travail avec le code de ce dépôt.

## Vue d'ensemble du projet

Dépôt centralisant les fichiers de configuration et scripts d'installation pour Windows et Linux.

## Structure du dépôt

Le dépôt est organisé en trois sections principales :

- **Windows** : Scripts PowerShell, configurations d'applications Windows, setup d'environnement de développement
- **Linux** : Scripts Bash, dotfiles système, setup d'environnement de développement  
- **Partagé** : Configurations cross-platform, listes de logiciels, documentation

## Commandes Git

Le dépôt utilise Git pour le versioning. Commandes principales :

```powershell
# Ajouter tous les fichiers
git add .

# Commit avec message
git commit -m "message"

# Pousser sur la branche main
git push origin main

# Vérifier l'état
git status
```

## Conventions

- Utiliser PowerShell pour les scripts Windows
- Utiliser Bash pour les scripts Linux
- Documenter les scripts avec des commentaires clairs
- Tester les scripts avant de commit
- Maintenir le README.md à jour avec la structure réelle du projet

## Notes de développement

- Ce dépôt est personnel mais ouvert aux suggestions via issues/PRs
- Les configurations doivent être génériques et éviter les chemins absolus spécifiques à une machine
- Toujours communiquer en français avec l'utilisateur
