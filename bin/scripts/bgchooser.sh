#!/bin/sh
#  ______      _ _      _____     _    _                                               _____
# |  ____|    (_) |    |  __ \   | |  | |                                             / ____|
# | |__   _ __ _| | __ | |  | |  | |__| | ___ _ __ _ __ _ __ ___   __ _ _ __  _ __   | (___  _ __
# |  __| | '__| | |/ / | |  | |  |  __  |/ _ \ '__| '__| '_ ` _ \ / _` | '_ \| '_ \   \___ \| '__|
# | |____| |  | |   <  | |__| |  | |  | |  __/ |  | |  | | | | | | (_| | | | | | | |  ____) | |_
# |______|_|  |_|_|\_\ |_____(_) |_|  |_|\___|_|  |_|  |_| |_| |_|\__,_|_| |_|_| |_| |_____/|_(_)

# Wallpaper setting script using Nitrogen - Laptop version updated 06/02/2025
# ~/bin/scripts/bgchooser.sh
#
IMAGE=$1
CONFIG="$HOME/.config/nitrogen/bg-saved.cfg"
BACKUP="$CONFIG.bak"
export GTK_THEME=Arc-Dark

# Use zenity for a GUI dropdown menu
MODE_NAME=$(zenity --list --title="Choose Wallpaper Mode" \
  --text="Select a wallpaper mode:" \
  --column="Mode" "Automatic" "Scaled" "Centered" "Tiled" "Zoomed" "Zoomed Fill")

# Handle cancel or empty input
if [ -z "$MODE_NAME" ]; then
  notify-send "Wallpaper not set" "No mode selected."
  exit 1
fi

# Map input to Nitrogen mode numbers
case $MODE_NAME in
    "Scaled")       MODE=0 ;;
    "Tiled")        MODE=1 ;;
    "Centered")     MODE=2 ;;
    "Zoomed")       MODE=3 ;;
    "Automatic")    MODE=4 ;;
    "Zoomed Fill")  MODE=5 ;;
    *) notify-send "Wallpaper not set" "Invalid mode selected."; exit 1 ;;
esac

echo "IMAGE: $IMAGE"
echo "MODE: $MODE ($MODE_NAME)"
echo "CONFIG: $CONFIG"
echo "BACKUP: $BACKUP"

# Backup current config
cp "$CONFIG" "$BACKUP"

# Write config based on mode
cat > "$CONFIG" <<EOF
[xin_-1]
file=$IMAGE
mode=$MODE
bgcolor=#000000
EOF

nitrogen --restore
# notify-send "Wallpaper set:" "$MODE: $IMAGE"
notify-send "Wallpaper set:" "$(basename "$IMAGE"), $MODE_NAME"

exit 0

