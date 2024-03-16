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
        # Aylur's GTK Shell (AGS)
        inputs.ags.homeManagerModules.default 
        ./apps/ags.nix
        # Matugen Palette Generator
        inputs.matugen.nixosModules.default
        # Hyprland config
        ./apps/hyprland/hyprmain.nix
        # Themes
        ./themes/gtk.nix
        ./themes/qt.nix
        # App dotfiles
        ./apps/ranger/ranger.nix
        ./apps/zsh.nix
        ./apps/kitty/kitty.nix
        ./apps/swappy/swappy.nix
        
    ];

    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;

    # Set wallpaper
    wallpaper = "~/Immagini/Sfondi/Splatoon\\\ Artworks/Group\\\ Photo.png";

    home = {
        username = "inkeaton";
        homeDirectory = "/home/${config.home.username}";
        stateVersion = "23.11";

        sessionPath = [
            "${config.home.homeDirectory}/.local/bin"
        ];
    
        # You can also create simple shell scripts directly inside your configuration.
        packages = [
            # (pkgs.writeShellScriptBin "cat"  ''bat'')
            # (pkgs.writeShellScriptBin "icat" ''kitten icat'')

            (pkgs.writeShellScriptBin "l" ''exa --icons'')
            (pkgs.writeShellScriptBin "la" ''exa --icons'')
            (pkgs.writeShellScriptBin "ll" ''exa -lah --icons'')
            (pkgs.writeShellScriptBin "ls" ''exa -lh --color=auto --icons'')

            (pkgs.writeShellScriptBin "os-update"  ''nix flake update --flake ${config.home.homeDirectory}/.samarkanda/#default'')
            (pkgs.writeShellScriptBin "os-rebuild" ''sudo nixos-rebuild switch --flake ${config.home.homeDirectory}/.samarkanda/#default'')
            (pkgs.writeShellScriptBin "os-list"    ''sudo nix-env --list-generations --profile /nix/var/nix/profiles/system'')
            (pkgs.writeShellScriptBin "os-clean"   ''nix-collect-garbage -d'')
        ];
        # Configure Cursor
        pointerCursor = {
            gtk.enable = true;
            x11.enable = true;
            package = pkgs.bibata-cursors;
            name = "Bibata-Modern-Classic";
            size = 24;
        };
    };

    # TO DO: Use xdg.desktopEntries.<name>.noDisplay to hide unwanted entries
    # custom .desktop files
    xdg.desktopEntries = {
        prismlauncher = {
            name = "Prism Launcher";    
            #genericName = "Minecraft Launcher";    
            exec = "nvidia-offload prismlauncher";    
            terminal = false;    
            #categories = [ "Game"];    
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
