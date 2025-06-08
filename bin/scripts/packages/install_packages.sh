#!/bin/bash

#  _____      _ _      ____     _   _
# | ____|_ __(_) | __ |  _ \   | | | | ___ _ __ _ __ _ __ ___   __ _ _ __  _ __
# |  _| | '__| | |/ / | | | |  | |_| |/ _ \ '__| '__| '_ ` _ \ / _` | '_ \| '_ \
# | |___| |  | |   <  | |_| |  |  _  |  __/ |  | |  | | | | | | (_| | | | | | | |
# |_____|_|  |_|_|\_\ |____(_) |_| |_|\___|_|  |_|  |_| |_| |_|\__,_|_| |_|_| |_|

# Install script to restore packages after system reinstall, updated 11/03/2024
# ~/bin/scripts/packages/install_packages.sh

input_file=$(find ~/ -name 'pkglst')

if [[ ! -f "$input_file" ]]; then
    echo "Package list not found, please check path"
    exit 1
fi

echo "installing packages from $input_file..."

sudo pacman -S --needed - < "$input_file"

echo "All packages from $input_file have been installed"





