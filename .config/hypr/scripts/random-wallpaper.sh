#!/usr/bin/env bash
# Script pour sélectionner un wallpaper aléatoire

WALLPAPER_DIR="$HOME/.config/wallpapers"

# Vérifie si le dossier existe
if [ ! -d "$WALLPAPER_DIR" ]; then
    echo "Erreur: Le dossier $WALLPAPER_DIR n'existe pas"
    exit 1
fi

# Sélectionne un fichier aléatoire (jpg, png, webp)
WALLPAPER=$(find "$WALLPAPER_DIR" -type f \( -name "*.jpg" -o -name "*.jpeg" -o -name "*.png" -o -name "*.webp" \) | shuf -n 1)

if [ -z "$WALLPAPER" ]; then
    echo "Erreur: Aucun wallpaper trouvé dans $WALLPAPER_DIR"
    exit 1
fi

echo "Wallpaper sélectionné: $WALLPAPER"

# Applique le wallpaper avec swaybg (kill l'ancien processus d'abord)
pkill swaybg 2>/dev/null
swaybg -i "$WALLPAPER" -m fill &

# Alternative avec hyprpaper si installé
# hyprctl hyprpaper wallpaper ",$WALLPAPER"
