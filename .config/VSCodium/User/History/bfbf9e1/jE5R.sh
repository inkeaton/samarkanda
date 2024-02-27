#!/usr/bin/env bash

#   .d8888b.                                                      888               888    
#  d88P  Y88b                                                     888               888    
#  Y88b.                                                          888               888    
#   "Y888b.    .d8888b 888d888 .d88b.   .d88b.  88888b.  .d8888b  88888b.   .d88b.  888888 
#      "Y88b. d88P"    888P"  d8P  Y8b d8P  Y8b 888 "88b 88K      888 "88b d88""88b 888    
#        "888 888      888    88888888 88888888 888  888 "Y8888b. 888  888 888  888 888    
#  Y88b  d88P Y88b.    888    Y8b.     Y8b.     888  888      X88 888  888 Y88..88P Y88b.  
#   "Y8888P"   "Y8888P 888     "Y8888   "Y8888  888  888  88888P' 888  888  "Y88P"   "Y888 


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