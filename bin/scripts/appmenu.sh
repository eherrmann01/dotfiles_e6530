#!/bin/sh
#  ______      _ _      _____     _    _                                               _____
# |  ____|    (_) |    |  __ \   | |  | |                                             / ____|
# | |__   _ __ _| | __ | |  | |  | |__| | ___ _ __ _ __ _ __ ___   __ _ _ __  _ __   | (___  _ __
# |  __| | '__| | |/ / | |  | |  |  __  |/ _ \ '__| '__| '_ ` _ \ / _` | '_ \| '_ \   \___ \| '__|
# | |____| |  | |   <  | |__| |  | |  | |  __/ |  | |  | | | | | | (_| | | | | | | |  ____) | |_
# |______|_|  |_|_|\_\ |_____(_) |_|  |_|\___|_|  |_|  |_| |_| |_|\__,_|_| |_|_| |_| |_____/|_(_)

# Application launcher using Rofi - updated 07/19/2025
# ~/bin/scripts/xmenudm.sh

DMENU="rofi -dmenu -i -matching fuzzy -sorting-method fzf -theme ~/.config/rofi/themes/appmenu.rasi"

category=$(printf "Apps\n\
Audio / Video\n\
Dev Tools\n\
Edit Config Files\n\
File Managers\n\
Imaging\n\
Office\n\
System Tools\n\
Terminals\n\
Web / Email\n\
Shutdown\nReboot\n" | $DMENU)

case "$category" in
    "Apps")
        choice=$(printf "Bitwarden\n\
Calculator\n\
Unit Converter\n\
Back\n" | $DMENU)

    case "$choice" in 
        "Bitwarden") exec bitwarden-desktop ;;
        "Calculator") exec galculator ;;
        "Unit Converter") exec /bin/convertall ;;
        "Back") exec "$0" ;;
    esac
    ;;

    "Audio / Video")
        choice=$(printf "Grayjay\n\
PulseAudio\n\
VLC\n\
Back\n" | $DMENU)

    case "$choice" in 
        "Grayjay") exec grayjay ;;
        "PulseAudio") exec pavucontrol ;;
        "VLC") exec vlc ;;
        "Back") exec "$0" ;;
    esac
    ;;

    "Dev Tools")
        choice=$(printf "Geany\n\
NeoVim\n\
VSCodium\n\
Back\n" | $DMENU)
    case "$choice" in 
        "Geany") exec geany ;;
        "NeoVim") exec kitty -e nvim ;;
        "VSCodium") exec vscodium ;;
        "Back") exec "$0" ;;
    esac
    ;;

    "Edit Config Files")
        choice=$(printf "Alacritty\n\
App Menu\n\
Bashrc\n\
I3\n\
Imwheel\n\
Kitty\n\
NeoVim\n\
Picom\n\
Polybar\n\
Qtile\n\
Vimrc\n\
Xfce\n\
Xmenu\n\
Zsh\n\
Zsh Aliases\n\
Back\n" | $DMENU)

    case "$choice" in 
        "Alacritty") exec kitty -e ~/bin/scripts/edit_scripts/edit_alacritty.sh ;;
        "App Menu") exec kitty -e ~/bin/scripts/edit_scripts/edit_appmenu.sh ;;
        "Bashrc") exec kitty -e ~/bin/scripts/edit_scripts/edit_bashrc.sh ;;
        "I3") exec kitty -e ~/bin/scripts/edit_scripts/edit_i3.sh ;;
        "Imwheel") exec kitty -e ~/bin/scripts/edit_scripts/edit_imwheel.sh ;;
        "Kitty") exec kitty -e ~/bin/scripts/edit_scripts/edit_kitty.sh ;;
        "NeoVim") exec kitty -e ~/bin/scripts/edit_scripts/edit_nvim.sh ;;
        "Picom") exec kitty -e ~/bin/scripts/edit_scripts/edit_picom.sh ;;
        "Polybar") exec kitty -e ~/bin/scripts/edit_scripts/edit_polybar.sh ;;
        "Qtile") exec kitty -e ~/bin/scripts/edit_scripts/edit_qtile.sh ;;
        "Vimrc") exec kitty -e ~/bin/scripts/edit_scripts/edit_vim.sh ;;
        "Xfce") exec kitty -e ~/bin/scripts/edit_scripts/edit_xfce.sh ;;
        "Xmenu") exec kitty -e ~/bin/scripts/edit_scripts/edit_xmenu.sh ;;
        "Zsh") exec kitty -e ~/bin/scripts/edit_scripts/edit_zsh.sh ;;
        "Zsh Aliases") exec kitty -e ~/bin/scripts/edit_scripts/edit_zsh_aliases.sh ;;
        "Back") exec "$0" ;;
    esac
    ;;

    "File Managers")
        choice=$(printf "Ranger\n\
Thunar\n\
Back\n" | $DMENU)

    case "$choice" in 
        "Ranger") exec kitty -e ranger ;;
        "Thunar") exec thunar ;;
        "Back") exec "$0" ;;
    esac
    ;;

    "Imaging")
        choice=$(printf "Darktable\n\
Gimp\n\
Inkscape\n\
Back\n" | $DMENU)
    case "$choice" in 
        "Darktable") exec /usr/sbin/darktable ;;
        "Gimp") exec /usr/sbin/gimp ;;
        "Inkscape") exec /usr/sbin/inkscape ;;
        "Back") exec "$0" ;;
    esac
    ;;

    "Office")
        choice=$(printf "Libre Office Base\n\
Libre Office Calc\n\
Libre Office Draw\n\
Libre Office Impress\n\
Libre Office Math\n\
Libre Office Write\n\
Back\n" | $DMENU)
    case "$choice" in 
        "Libre Office Base") exec libreoffice --base ;;
        "Libre Office Calc") exec libreoffice --calc ;;
        "Libre Office Draw") exec libreoffice --draw ;;
        "Libre Office Impress") exec libreoffice --impress ;;
        "Libre Office Math") exec libreoffice --math ;;
        "Libre Office Write") exec libreoffice --writer ;;
        "Back") exec "$0" ;;
    esac
    ;;

    "System Tools")
        choice=$(printf "Barrier\n\
Bashtop\n\
Deskflow\n\
File Search\n\
Flameshot\n\
Gparted\n\
HTOP\n\
LXAppearance\n\
Nitrogen\n\
QT Theme Manager\n\
Pacseek\n\
Timeshift\n\
Tweaks\n\
Back\n" | $DMENU )
        case "$choice" in 
            "Barrier") exec barrier ;;
            "Bashtop") exec kitty -e bashtop ;;
            "Deskflow") exec deskflow ;;
            "File Search") exec catfish ;;
            "Flameshot") exec flameshot ;;
            "Gparted") exec gparted ;;
            "HTOP") exec kitty -e htop ;;
            "LXAppearance") exec lxappearance ;;
            "Nitrogen") exec nitrogen ;;
            "Pacseek") kitty -e ~/bin/scripts/pacseek_search.sh ;;
            "QT Theme Manager") exec qt5ct ;;
            "Timeshift") exec timeshift-launcher ;;
            "Tweaks") exec archlinux-tweak-tool ;;
            "Back") exec "$0" ;;
        esac
        ;;
        
    "Terminals")
        choice=$(printf "Alacritty\n\
Kitty\n\
Termite\n\
URXVT\n\
XFCE4 Terminal\n\
Back\n" | $DMENU)
        case "$choice" in 
            "Alacritty") exec alacritty ;;
            "Kitty") exec kitty ;;
            "Termite") exec termite ;;
            "URXVT") exec urxvt ;;
            "XFCE4 Terminal") exec xfce4-terminal ;;
            "Back") exec "$0" ;;
        esac
        ;;

    "Web / Email")
        choice=$(printf "Brave\n\
Chrome\n\
Firefox\n\
Mail\n\
Protonmail Bridge\n\
Zen Browser\n\
Back\n" | $DMENU)
        case "$choice" in 
            "Brave") exec brave ;;
            "Chrome") exec chromium ;;
            "Firefox") exec firefox ;;
            "Mail") exec thunderbird ;;
            "ProtonMail Bridge") exec /usr/sbin/protonmail-bridge ;;
            "Zen Browser") exec /usr/sbin/zen-browser ;;
            "Back") exec "$0" ;;
        esac
        ;;

    "Shutdown")
        exec poweroff
        ;;

    "Reboot")
        exec reboot
        ;;
esac

exit 0
