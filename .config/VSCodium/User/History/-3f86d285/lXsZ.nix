{ config, pkgs, inputs, ... }:

{
    # Imported modules
    imports = [ 
        # Hyprland config
        ./hyprland/hyprmain.nix
        # Aylur's GTK Shell (AGS)
        inputs.ags.homeManagerModules.default 
    ];

    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;

    # Set wallpaper
    # wallpaper = "~/Immagini/Sfondi/EVA.png";

    home = {
        username = "inkeaton";
        homeDirectory = "/home/${config.home.username}";
        stateVersion = "23.11";

        sessionPath = [
            "${config.home.homeDirectory}/.local/bin"
        ];
        
        sessionVariables = {
            EDITOR =         "nano";
            VISUAL =         "codium";
            BROWSER =        "firefox";
            DESKTOP_DIR=     "${config.home.homeDirectory}";
            DOCUMENTS_DIR=   "${config.home.homeDirectory}/Documenti";
            DOWNLOAD_DIR=    "${config.home.homeDirectory}/Scaricati";
            MUSIC_DIR=       "${config.home.homeDirectory}/Musica";
            GAMES_DIR=       "${config.home.homeDirectory}/Giochi";
            PICTURES_DIR=    "${config.home.homeDirectory}/Immagini";
            WALLPAPERS_DIR=  "${config.home.homeDirectory}/Immagini/Sfondi";
            SCREENSHOTS_DIR= "${config.home.homeDirectory}/Immagini/Schermate";
            PUBLICSHARE_DIR= "${config.home.homeDirectory}/";
            TEMPLATES_DIR=   "${config.home.homeDirectory}/";
            VIDEOS_DIR=      "${config.home.homeDirectory}/Video";
        };
    
        # You can also create simple shell scripts directly inside your configuration.
        packages = [
            # example
            (pkgs.writeShellScriptBin "my-hello" ''
                echo "Hello, ${config.home.username}!"
            '')
        ];

        # Home Manager is pretty good at managing dotfiles. The primary way to manage
        # plain files is through 'home.file'.
        file = {
        };

        # Configure Cursor
        pointerCursor = {
            gtk.enable = true;
            x11.enable = true;
            package = pkgs.bibata-cursors;
            name = "Bibata-Modern-Classic";
            size = 24;
        };
    };


    # Configure AGS
    programs.ags = {
        enable = true;

        # null or path, leave as null if you don't want hm to manage the config
        configDir = null;

        # additional packages to add to gjs's runtime
        extraPackages = [ pkgs.libsoup_3 ];
    };

    # manage gtk theme
    gtk = {
        enable = true;
        theme = {
            name = "Adwaita-OLED";
        };

        iconTheme = {
            name = "kora";
            package = pkgs.kora-icon-theme;
        };

        font = {
            name = "SF Pro Rounded Regular";
        };
    };

    # manage qt theme 
    qt = {
        enable = true;
        platformTheme = "gtk";
        style= {
            name = "adwaita-dark";
            package = pkgs.adwaita-qt;
        };
    };
}