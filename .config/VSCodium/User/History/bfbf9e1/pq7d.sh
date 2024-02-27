#!/usr/bin/env bash

# Flags:

# r: region
# s: screen
#
# c: clipboard
# f: file
# i: interactive

# p: pixel

if [[ $1 == rc ]]; then
    grim -g "$(slurp -b '#000000b0' -c '#00000000')" - | wl-copy
    notify-send 'Selezione Copiata!' 

elif [[ $1 == rf ]]; then
    mkdir -p $(xdg-user-dir SCREENSHOTS)
    filename=$(xdg-user-dir SCREENSHOTS)/$(date +%Y-%m-%d_%H-%M-%S).png
    grim -g "$(slurp -b '#000000b0' -c '#00000000')" $filename
    notify-send 'Selezione Salvata!' $filename

elif [[ $1 == ri ]]; then
    grim -g "$(slurp -b '#000000b0' -c '#00000000')" - | swappy -f -

elif [[ $1 == sc ]]; then
    filename=$(xdg-user-dir SCREENSHOTS)/%Y-%m-%d_%H-%M-%S.png
    grim - | wl-copy
    notify-send 'Schemata Copiata!'

elif [[ $1 == sf ]]; then
    mkdir -p $(xdg-user-dir SCREENSHOTS)
    filename=$(xdg-user-dir SCREENSHOTS)/$(date +%Y-%m-%d_%H-%M-%S).png
    grim $filename
    notify-send 'Schermata Salvata!' $filename

elif [[ $1 == si ]]; then
    grim - | swappy -f -

elif [[ $1 == p ]]; then
    color=$(hyprpicker -a)
    notify-send 'Colore Copiato!' $color
    wl-copy $color
fi