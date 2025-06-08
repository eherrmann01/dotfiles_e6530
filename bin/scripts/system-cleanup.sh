#!/bin/sh
#   ______      _ _      _____     _    _                                               _____
#  |  ____|    (_) |    |  __ \   | |  | |                                             / ____|
#  | |__   _ __ _| | __ | |  | |  | |__| | ___ _ __ _ __ _ __ ___   __ _ _ __  _ __   | (___  _ __
#  |  __| | '__| | |/ / | |  | |  |  __  |/ _ \ '__| '__| '_ ` _ \ / _` | '_ \| '_ \   \___ \| '__|
#  | |____| |  | |   <  | |__| |  | |  | |  __/ |  | |  | | | | | | (_| | | | | | | |  ____) | |_
#  |______|_|  |_|_|\_\ |_____(_) |_|  |_|\___|_|  |_|  |_| |_| |_|\__,_|_| |_|_| |_| |_____/|_(_)

# A script to clean up system files, updated 06/03/2025
# ~/bin/scripts/shell_scripts/system-cleanup.sh

LOG_FILE=~/system-cleanup.log
exec > >(tee -a "$LOG_FILE") 2>&1
echo "system cleanup started at $(date)"
echo "Dry run mode: $DRY_RUN"
echo "Logging to $LOG_FILE"

set -euo pipefail
IFS=$'\n\t'

# Default options
DRY_RUN=false
LOG_FILE=""

while [[ $# -gt 0 ]]; do
  case "$1"  in
      --dry-run)
        DRY_RUN=true
        ;;
      --log)
        shift
        LOG_FILE="$1"
        ;;
      * )
        eecho "Unknown option: $1"
        exit 1
        ;;
  esac
  shift
done

echo "Checking disk usage before cleanup..."

ROOT_FREE_BEFORE=$(df -h / | awk 'NR==2 {print $4}')
HOME_FREE_BEFORE=$(df -h /home | awk 'NR==2 {print $4}')

echo "Free space before cleanup:"
echo "  /        : $ROOT_FREE_BEFORE"
echo "  /home    : $HOME_FREE_BEFORE"

# Clean package cache
echo "Cleaning package cache..."

if command -v paccache &>/dev/null; then
  if [[ "$DRY_RUN" == true ]]; then
    echo "[DRY RUN] Would run: sudo paccache -r"
  else
    sudo paccache -r
  fi 
else
  echo "paccache not found. Skipping package cache cleanup." 
fi

# Clean orphaned packages
# Run pacman -Qdtq | xargs -r pacman -Qi to get detailed package information
echo "Looking for orphaned packages..."

if command -v pacman &>/dev/null; then
    ORPHANS=$(pacman -Qdtq || true)
    if [[ -z "$ORPHANS" ]]; then
        echo "No orphaned packages found."
    else
        echo "Found orphaned packages:"
        echo "$ORPHANS"
        if [[ "$DRY_RUN" == true ]]; then
            echo "[DRY RUN] Would run: sudo pacman -Rns $ORPHANS"
        else
            sudo pacman -Rns $ORPHANS
        fi
    fi
else
    echo "pacman not found. Skipping orphan cleanup."
fi

# Clean cached files
echo "Cleaning ~/.cache/..."

if [[ "$DRY_RUN" == true ]]; then
  echo "[DRY_RUN] Would run: rm -rf ~/.cache/*"
else
  rm -rf ~/.cache/*
fi

# Clean npm cache
echo "Cleaning npm cache..."

if command -v npm &>/dev/null; then
    if [[ "$DRY_RUN" == true ]]; then
        echo "[DRY RUN] Would run: npm cache clean --force"
    else
        npm cache clean --force
    fi
else
    echo "npm not found. Skipping npm cache cleanup."
fi

# Clean unused flatpacks
echo "Cleaning Flatpak leftovers..."

if command -v flatpak &>/dev/null; then
    if [[ "$DRY_RUN" == true ]]; then
        echo "[DRY RUN] Would run: flatpak uninstall --unused -y"
    else
        flatpak uninstall --unused -y
    fi
else
    echo "flatpak not found. Skipping Flatpak cleanup."
fi

# Clean up journal logs, keeping the last 7 days
echo "Cleaning journal logs (keeping 7 days)..."

if [[ "$DRY_RUN" == true ]]; then
    echo "[DRY RUN] Would run: sudo journalctl --vacuum-time=7d"
else
    sudo journalctl --vacuum-time=7d
fi

# Take out the trash
echo "Emptying trash..."

TRASH_PATH=~/.local/share/Trash

if [[ "$DRY_RUN" == true ]]; then
    echo "[DRY RUN] Would run: rm -rf $TRASH_PATH/files/*"
    echo "[DRY RUN] Would run: rm -rf $TRASH_PATH/info/*"
else
    rm -rf "$TRASH_PATH/files/"*
    rm -rf "$TRASH_PATH/info/"*
fi

echo "Checking disk usage after cleanup..."

ROOT_FREE_AFTER=$(df -h / | awk 'NR==2 {print $4}')
HOME_FREE_AFTER=$(df -h /home | awk 'NR==2 {print $4}')

echo "Free space after cleanup:"
echo "  /        : $ROOT_FREE_AFTER"
echo "  /home    : $HOME_FREE_AFTER"













