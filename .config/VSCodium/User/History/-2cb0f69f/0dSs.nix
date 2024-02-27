# 888    888                                      888b     d888                                                      
# 888    888                                      8888b   d8888                                                      
# 888    888                                      88888b.d88888                                                      
# 8888888888  .d88b.  88888b.d88b.   .d88b.       888Y88888P888  8888b.  88888b.   8888b.   .d88b.   .d88b.  888d888 
# 888    888 d88""88b 888 "888 "88b d8P  Y8b      888 Y888P 888     "88b 888 "88b     "88b d88P"88b d8P  Y8b 888P"   
# 888    888 888  888 888  888  888 88888888      888  Y8P  888 .d888888 888  888 .d888888 888  888 88888888 888     
# 888    888 Y88..88P 888  888  888 Y8b.          888   "   888 888  888 888  888 888  888 Y88b 888 Y8b.     888     
# 888    888  "Y88P"  888  888  888  "Y8888       888       888 "Y888888 888  888 "Y888888  "Y88888  "Y8888  888     
#                                                                                              888                  
#                                                                                         Y8b d88P                  
#                                                                                          "Y88P"                   

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
    # TO DO: Use xdg.desktopEntries.<name>.noDisplay to hide unwanted entries
    # custom .desktop files
    xdg.desktopEntries = {
        prismlauncher = {
            name = "Prism Launcher";    
            genericName = "Minecraft Launcher";    
            exec = "nvidia-offload prismlauncher";    
            terminal = false;    
            categories = [ "Game"];    
        };
    };
}

#⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣀⣀⣀⣀⣀⣀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
#⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠛⢿⣿⣿⣿⣷⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
#⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⣿⣿⣿⣿⣷⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀  ######################
#⠀⠀⠀⠀⠀⠀⣠⣄⡀⠀⠀⠀⠀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
#⠀⠀⠀⠀⣠⣾⣿⣿⣿⠖⢀⣼⣆⠈⠻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣆⠀⢲⣶⣶⣶⣶⣄⠀⠀⠀⠀  STRETTA È LA FOGLIA 
#⠀⠀⠠⠞⠛⠛⠿⣿⠏⢀⣾⣿⣿⣷⣄⠀⢤⣤⣤⣤⣤⣤⣤⣤⣤⡄⠙⣿⣿⣧⠀⢻⣿⣿⣿⣿⡆⠀⠀⠀
#⠀⠀⠀⠀⠀⠀⠀⠈⢀⣾⣿⣿⣿⣿⣿⣷⡄⠙⠛⠛⠛⠛⠻⣿⣿⣿⣆⠈⢿⣿⣧⡀⠻⣿⣿⠟⠁⠀⠀⠀  LARGA È LA VIA
#⠀⠀⠀⠀⠀⠀⠀⢠⣿⣿⣿⣿⣿⣿⣿⠿⠁⣠⡀⠰⣶⣶⣆⠈⠻⣿⣿⣦⠈⢻⣿⣷⡀⠙⠁⠀⠀⠀⠀⠀
#⠀⠀⠀⠀⠀⠀⠀⠛⠋⠉⢉⣁⣀⣠⣤⣄⠘⢿⣿⣦⣤⣀⣀⠁⢀⣈⡉⠉⠁⠀⠙⠛⠓⠀⠀⠀⠀⠀⠀⠀  VOI DITE LA VOSTRA 
#⠀⠀⠀⠀⠀⠀⠀⠻⣿⣿⣿⣿⣿⣿⣿⣿⣧⠈⠛⠛⠛⠛⠁⣴⣿⣿⣿⣿⣿⣿⣿⣿⠖⠀⠀⠀⠀⠀⠀⠀
#⠀⠀⠀⠀⠀⠀⢠⡄⠙⢿⣿⣿⣿⣿⣿⠟⠁⣴⣿⣿⣿⣿⣦⠈⠻⣿⣿⣿⣿⣿⡿⠋⢠⣾⣶⣄⠀⠀⠀⠀  CH'IO HO DETTO LA MIA   
#⠀⠀⠀⠀⠀⢰⣿⣿⣦⡀⠻⣿⣿⡿⠋⣠⣾⣿⣿⣿⣿⣿⣿⣷⣄⠙⢿⣿⣿⠟⠁⠐⢿⣿⣿⣿⣷⠀⠀⠀
#⠀⠀⠀⠀⠐⠋⠉⠉⠉⠀⠀⠘⠏⢀⣼⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣦⡀⠻⠋⠀⠀⠀⠀⠙⣿⣿⠃⠀⠀⠀  ######################
#⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣤⣤⣤⣤⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡿⠁⠀⠀⠀⠀
#⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⣿⣿⣿⣧⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠁⠀⠀⠀⠀⠀  inkeaton
#⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣴⡿⠿⠿⠛⠛⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
#⠀⠀⠀⠀⠀⠀⠀
