{ config, lib, pkgs, inputs, ... }:

{
    # Session Variables
    environment.sessionVariables = rec {
        # If your cursor becomes invisible
        WLR_NO_HARDWARE_CURSORS ="1";
        # Hint electron apps to use wayland
        NIXOS_OZONE_WL          ="1";
        # Set Qt apps scale
        QT_AUTO_SCREEN_SET_FACTOR ="0";
        QT_SCALE_FACTOR           ="2";
        #QT_FONT_DPI               ="96";
        # Apps
        EDITOR               ="nano";
        VISUAL               ="codium";
        BROWSER              ="firefox";
        # Directories
        XDG_DESKTOP_DIR      ="$HOME/";
        XDG_DOCUMENTS_DIR    ="$HOME/Documenti";
        XDG_DOWNLOAD_DIR     ="$HOME/Scaricati";
        XDG_MUSIC_DIR        ="$HOME/Musica";
        XDG_GAMES_DIR        ="$HOME/Giochi";
        XDG_PICTURES_DIR     ="$HOME/Immagini";
        XDG_WALLPAPERS_DIR   ="$HOME/Immagini/Sfondi";
        XDG_SCREENSHOTS_DIR  ="$HOME/Immagini/Schermate";
        XDG_PUBLICSHARE_DIR  ="$HOME/";
        XDG_TEMPLATES_DIR    ="$HOME/";
        XDG_VIDEOS_DIR       ="$HOME/Video";
    };
}