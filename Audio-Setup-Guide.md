# 🎵 Guide de synchronisation Audio - Setup Multi-PC

Ce guide récapitule les plugins à synchroniser via NAS (Qsync) et les logiciels à installer sur chaque PC.

---

## 📁 Structure de synchronisation Qsync

```
C:\Users\jouan\Qsync\GamesDev\_Library\DAW\
├── Plugins\
│   ├── VST3\          ← Plugins autonomes (.vst3)
│   ├── VST\           ← Plugins VST2 (.dll)
│   └── CLAP\          ← Plugins CLAP (.clap)
├── Samples\
│   ├── SoundBanks\
│   │   ├── NativeInstruments\
│   │   ├── Splice\
│   │   └── Spitfire\
│   └── Loops\
│       └── Splice\
├── Presets\
│   ├── Vital\
│   ├── Serum\
│   ├── Pigments\
│   ├── Analog Lab\
│   └── Splice\
└── Templates\
    ├── FL Studio\
    └── Reaper\
```

---

## ✅ Plugins synchronisables (fichiers autonomes)

Ces plugins sont de simples fichiers à copier sur le NAS. Ils fonctionnent sans installation supplémentaire.

| Plugin | Type | Format | Dossier Qsync |
|--------|------|--------|---------------|
| **Vital** | Synthé wavetable | .vst3 | `Plugins\VST3\` |
| **Dexed** | Synthé FM (DX7) | .vst3 | `Plugins\VST3\` |
| **Magical 8bit Plug** | Chiptune NES | .vst3/.dll | `Plugins\VST3\` |
| **Valhalla Supermassive** | Reverb/Delay | .vst3 | `Plugins\VST3\` |
| **TDR Nova** | EQ dynamique | .vst3 | `Plugins\VST3\` |
| **OTT** (Xfer) | Compression multiband | .dll | `Plugins\VST\` |
| **Sitala** | Drum machine | .vst3 | `Plugins\VST3\` |
| **MT Power Drum Kit** | Batterie réaliste | .vst3 | `Plugins\VST3\` |
| **ReaLearn** | Mapping MIDI (Reaper) | .dll | `Plugins\VST\` |

### Presets synchronisables

| Plugin | Emplacement source | Destination Qsync |
|--------|-------------------|-------------------|
| **Vital** | `%APPDATA%\vital\` | `Presets\Vital\` |
| **Serum** | `Documents\Xfer\Serum Presets\` | `Presets\Serum\` |
| **Dexed** | Fichiers .syx | `Presets\Dexed\` |

---

## ❌ Plugins NON synchronisables (installation requise sur chaque PC)

Ces plugins nécessitent un **gestionnaire de licences** ou un **launcher** installé localement.

### 🎹 Arturia (MiniLab 3 Bundle)

| Plugin/Logiciel | Géré par | Notes |
|-----------------|----------|-------|
| **Analog Lab V** | Arturia Software Center | 500+ presets de synthés Arturia |
| **Analog Lab Intro** | Arturia Software Center | Version incluse avec MiniLab 3 |
| **Pigments** | Arturia Software Center | Synthé wavetable avancé |
| **Mini V** | Arturia Software Center | Émulation Minimoog |
| **Autres V Collection** | Arturia Software Center | Si tu en achètes |

**Synchronisable :** Presets personnalisés → `Presets\Analog Lab\`, `Presets\Pigments\`

---

### 🎻 Native Instruments

| Plugin/Logiciel | Géré par | Notes |
|-----------------|----------|-------|
| **Komplete Start** | Native Access | 2000+ sons gratuits |
| **Kontakt** (Player/Full) | Native Access | Lecteur de libraries |
| **The Gentleman** | Native Access | Piano (bundle MiniLab 3) |
| **Autres libraries NI** | Native Access | Pianos, orchestres, etc. |

**Synchronisable :** Libraries `.nkx` → `Samples\SoundBanks\NativeInstruments\`

---

### 🎼 Spitfire Audio

| Plugin/Logiciel | Géré par | Notes |
|-----------------|----------|-------|
| **LABS** (65 packs gratuits) | Spitfire Audio App | Instruments cinématiques |
| **BBC Symphony Orchestra** | Spitfire Audio App | Si tu l'as |
| **Autres libraries Spitfire** | Spitfire Audio App | — |

**Synchronisable :** Libraries samplées → `Samples\SoundBanks\Spitfire\`

---

### 🎹 UVI

| Plugin/Logiciel | Géré par | Notes |
|-----------------|----------|-------|
| **UVI Workstation** | UVI Portal | Lecteur gratuit |
| **Model D** | UVI Portal | Piano Steinway (bundle MiniLab 3) |
| **Autres instruments UVI** | UVI Portal | — |

**Synchronisable :** Libraries `.ufs` → `Samples\SoundBanks\UVI\`

---

### 🌊 Waves

| Plugin/Logiciel | Géré par | Notes |
|-----------------|----------|-------|
| **Plugins Waves** | Waves Central | EQ, compresseurs, etc. |

**Synchronisable :** Presets → `Presets\Waves\`

---

### 🔐 iLok (Gestionnaire de licences)

| Ce qu'il gère | Notes |
|---------------|-------|
| Licences tierces (certains plugins pro) | Slate Digital, Soundtoys, etc. |

**Note :** iLok stocke les licences dans le cloud ou sur une clé USB physique. Pas de synchronisation NAS nécessaire — il suffit de se connecter avec ton compte.

---

## 💻 Logiciels à installer sur CHAQUE PC

### Gestionnaires de plugins (obligatoires)

| Logiciel | Téléchargement | Compte requis |
|----------|----------------|---------------|
| **Arturia Software Center** | [arturia.com/support](https://www.arturia.com/support/downloads&manuals) | Oui (gratuit) |
| **Native Access** | [native-instruments.com](https://www.native-instruments.com/en/specials/native-access/) | Oui (gratuit) |
| **Spitfire Audio App** | [spitfireaudio.com](https://www.spitfireaudio.com/info/library-manager) | Oui (gratuit) |
| **UVI Portal** | [uvi.net](https://www.uvi.net/uvi-portal) | Oui (gratuit) |
| **Waves Central** | [waves.com](https://www.waves.com/downloads/central) | Oui (gratuit) |
| **iLok License Manager** | [ilok.com](https://www.ilok.com/#!license-manager) | Oui (gratuit) |

### Pour le MiniLab 3

| Logiciel | Téléchargement | Usage |
|----------|----------------|-------|
| **MIDI Control Center** | [arturia.com/support](https://www.arturia.com/support/downloads&manuals) | Configuration clavier, templates, firmware |

### DAW (Digital Audio Workstation)

| Logiciel | Notes |
|----------|-------|
| **FL Studio** | Licence liée au compte Image-Line (login sur chaque PC) |
| **Reaper** | Licence portable (fichier .key) — synchronisable |
| **Ableton Live Lite** | Inclus avec MiniLab 3 (code unique) |

---

## 🔄 Workflow d'installation sur un nouveau PC

### Étape 1 : Installer les gestionnaires

```
1. Arturia Software Center    → Se connecter → Installer Analog Lab
2. Native Access              → Se connecter → Installer Komplete Start
3. Spitfire Audio App         → Se connecter → Installer LABS
4. UVI Portal                 → Se connecter → Installer Model D
5. Waves Central              → Se connecter → Installer plugins Waves
6. iLok License Manager       → Se connecter → Synchroniser licences
7. MIDI Control Center        → Configurer MiniLab 3
```

### Étape 2 : Synchroniser Qsync

```
Attendre que Qsync synchronise le dossier GamesDev\_Library\DAW\
```

### Étape 3 : Configurer les DAW

#### FL Studio
```
Options > File Settings > VST plugins extra search folder
→ C:\Users\jouan\Qsync\GamesDev\_Library\DAW\Plugins\VST3
→ Rescan
```

#### Reaper
```
Exécuter : dotfiles\scripts\gamesdev\Setup-ReaperVST.ps1
Ou manuellement : Options > Preferences > Plug-ins > VST > Edit path list
→ C:\Users\jouan\Qsync\GamesDev\_Library\DAW\Plugins\VST3
→ C:\Users\jouan\Qsync\GamesDev\_Library\DAW\Plugins\VST
→ C:\Users\jouan\Qsync\GamesDev\_Library\DAW\Plugins\CLAP
→ Re-scan
```

---

## 📋 Checklist récapitulative

### À synchroniser via NAS ✅

- [ ] Plugins autonomes (VST3/VST/CLAP)
- [ ] Presets (Vital, Serum, Pigments, Analog Lab, Dexed)
- [ ] Samples et libraries (quand possible)
- [ ] Templates FL Studio et Reaper
- [ ] Licence Reaper (.key)

### À installer sur chaque PC ❌

- [ ] Arturia Software Center + plugins
- [ ] Native Access + Komplete Start + Kontakt
- [ ] Spitfire Audio App + LABS
- [ ] UVI Portal + Model D
- [ ] Waves Central + plugins
- [ ] iLok License Manager
- [ ] MIDI Control Center
- [ ] FL Studio (login compte)
- [ ] Reaper

---

## 📝 Notes importantes

1. **Licences cloud** : La plupart des gestionnaires (Arturia, NI, Spitfire, UVI) gèrent les licences dans le cloud. Tu peux installer sur plusieurs PC sans problème tant que tu te connectes avec le même compte.

2. **Limite d'installations** : Certains éditeurs limitent le nombre de PC simultanés (généralement 2-3). Vérifie les conditions de chaque éditeur.

3. **Samples volumineux** : Les libraries Kontakt/Spitfire/UVI peuvent faire plusieurs Go. Tu peux soit les synchroniser via NAS, soit les re-télécharger sur chaque PC selon ta connexion.

4. **Configuration des chemins** : Après synchronisation Qsync, pense à re-scanner les plugins dans tes DAW.

---

*Dernière mise à jour : Décembre 2024*
