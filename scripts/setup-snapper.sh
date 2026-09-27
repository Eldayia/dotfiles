#!/usr/bin/env bash
set -Eeuo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
if ((EUID != 0)); then
    echo "Lancer : sudo bash $ROOT/scripts/setup-snapper.sh" >&2
    exit 1
fi
[[ $(findmnt -n -o FSTYPE -T /) == btrfs ]] || {
    echo "La racine doit être en Btrfs." >&2
    exit 1
}
if [[ ! -f /etc/snapper/configs/root ]]; then
    [[ ! -e /.snapshots ]] || {
        echo "Une arborescence /.snapshots existe déjà : vérifier sa configuration avant de continuer." >&2
        exit 1
    }
    snapper -c root create-config /
else
    grep -qx 'SUBVOLUME="/"' /etc/snapper/configs/root || {
        echo "La configuration root existante ne cible pas /." >&2
        exit 1
    }
fi
backup_dir="/var/lib/dotfiles-backups/snapper-$(date +%Y%m%d-%H%M%S)"
install -d -m 700 "$backup_dir"
cp -a /etc/snapper/configs/root "$backup_dir/root"
policy=()
while IFS= read -r entry; do
    [[ -z "$entry" || "$entry" == \#* ]] && continue
    [[ "$entry" =~ ^[A-Z_]+=(yes|no|[0-9]+)$ ]] || {
        echo "Entrée de politique invalide : $entry" >&2
        exit 1
    }
    policy+=("$entry")
done < "$ROOT/system/snapper/root-policy.conf"
snapper -c root set-config "${policy[@]}"
systemctl enable --now snapper-cleanup.timer
# snap-pac creates pre/post snapshots of the root configuration by default.
if [[ ! -f /var/lib/snapper/dotfiles-baseline ]]; then
    snapper -c root create --description "Base dotfiles : Snapper configuré" --cleanup-algorithm number --print-number
    install -d /var/lib/snapper
    touch /var/lib/snapper/dotfiles-baseline
fi
snapper -c root list
printf '\nSnapshots : racine uniquement ; /home et /boot séparés ne sont pas inclus.\n'
