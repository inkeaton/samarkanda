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
    ];

    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;

    home = {
        username = "inkeaton";
        homeDirectory = "/home/inkeaton";
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

    # Configure Hyprland
    wayland.windowManager.hyprland = {
        enable = true;

        settings = {
            ########################################################################################
            # BINDINGS
            ########################################################################################
            "$mainMod" = "SUPER";

            bind = [ 
                # Brightness keybinds (with AGS)
                "XF86MonBrightnessUp,     exec, ags --run-js \"brightness.screen_value += 0.05\""
                "XF86MonBrightnessDown,   exec, ags --run-js \"brightness.screen_value -= 0.05\""

                # Volume Keybinds
                "XF86AudioRaiseVolume,    exec, pamixer -i 5"
                "XF86AudioLowerVolume,    exec, pamixer -d 5"
                "XF86AudioMute,           exec, pamixer -t"
                "XF86AudioMicMute,        exec, pamixer --default-source -t"

                # Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more

                # Window management
                "$mainMod, Q,               killactive," 
                "$mainMod SHIFT, Q,         exit,"
                "$mainMod, M,               fullscreen, 1"
                "$mainMod, F,               fullscreen, 0"
                "$mainMod, Space,           togglefloating"
                "$mainMod, J,               togglesplit"  

                # Launchers
                "$mainMod, Return,          exec, kitty"
                "$mainMod, E,               exec, kitty ranger"
                "$mainMod, H,               exec, kitty btop"
                "$mainMod, R,               exec, rofi -show drun"
                "$mainMod, W,               exec, ~/.local/bin/rofi-wifi-menu"
                "$mainMod, A,               exec, ~/.local/bin/rofi-radio-menu"
                # Requires rofi-power-menu (AUR)
                "$mainMod, P,               exec, rofi -show p -modi p:rofi-power-menu"

                # Screenshots
                "Print,                     exec, ~/.config/hypr/scripts/screenshot.sh sc"
                "SUPER, Print,              exec, ~/.config/hypr/scripts/screenshot.sh sf"
                "CTRL, Print,               exec, ~/.config/hypr/scripts/screenshot.sh si"
                "SHIFT, Print,              exec, ~/.config/hypr/scripts/screenshot.sh rc"
                "SUPER SHIFT, Print,        exec, ~/.config/hypr/scripts/screenshot.sh rf"
                "CTRL SHIFT, Print,         exec, ~/.config/hypr/scripts/screenshot.sh ri"

                # Color picker
                "SUPER, C,                  exec, ~/.config/hypr/scripts/screenshot.sh p"

                # Move focus with mainMod + arrow keys
                "$mainMod, left,            workspace, m-1"
                "$mainMod, right,           workspace, m+1"

                # Switch workspaces with mainMod + [0-9]
                "$mainMod, 1,               workspace, 1"
                "$mainMod, 2,               workspace, 2"
                "$mainMod, 3,               workspace, 3"
                "$mainMod, 4,               workspace, 4"
                "$mainMod, 5,               workspace, 5"
                "$mainMod, 6,               workspace, 6"
                "$mainMod, 7,               workspace, 7"
                "$mainMod, 8,               workspace, 8"
                "$mainMod, 9,               workspace, 9"
                "$mainMod, 0,               workspace, 10"

                # Move active window to a workspace with mainMod + SHIFT + [0-9]
                "$mainMod SHIFT, 1,         movetoworkspace, 1"
                "$mainMod SHIFT, 2,         movetoworkspace, 2"
                "$mainMod SHIFT, 3,         movetoworkspace, 3"
                "$mainMod SHIFT, 4,         movetoworkspace, 4"
                "$mainMod SHIFT, 5,         movetoworkspace, 5"
                "$mainMod SHIFT, 6,         movetoworkspace, 6"
                "$mainMod SHIFT, 7,         movetoworkspace, 7"
                "$mainMod SHIFT, 8,         movetoworkspace, 8"
                "$mainMod SHIFT, 9,         movetoworkspace, 9"
                "$mainMod SHIFT, 0,         movetoworkspace, 10"

                # Scroll through existing workspaces with mainMod + scroll
                "$mainMod, mouse_down,      workspace, e+1"
                "$mainMod, mouse_up,        workspace, e-1"
            ];

            # Move/resize windows with mainMod + LMB/RMB and dragging
            bindm = [
                "$mainMod, mouse:272,      movewindow"
                "$mainMod, mouse:273,      resizewindow"
            ];

            gestures = {
                workspace_swipe = "on"
            };

            input = {
                kb_layout = "it"
                follow_mouse = "1"

                touchpad = {
                    natural_scroll = "yes"
                }

                sensitivity = "0"
            };

            ########################################################################################
            # WINDOWS
            ########################################################################################

            general = {
                gaps_in = "5"
                gaps_out = "20"
                border_size = "0"
                "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg"
                "col.inactive_border" = "rgba(595959aa)"

                layout = "dwindle"
            };

            decoration = {
                # round corners
                rounding = "15"
                # shadows
                drop_shadow = "yes"
                shadow_range = "4"
                shadow_render_power = "3"
                "col.shadow" = "rgba(1a1a1aee)"
                # blur
                blur = {
                    enabled = "yes"
                    new_optimizations = "true"
                    size = "10"
                    passes = "3"
                    xray = "true"
                };
            };

            animations = {
                enabled = "yes"

                bezier = "myBezier, 0.05, 0.9, 0.1, 1.05"

                animation = [
                    "windows, 1, 7, myBezier"
                    "windowsOut, 1, 7, default, popin 80%"
                    "border, 1, 10, default"
                    "borderangle, 1, 8, default"
                    "fade, 1, 7, default"
                    "workspaces, 1, 6, default"
                ];
            };

            dwindle = {
                # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
                pseudotile = "yes" # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
                preserve_split = "yes" # you probably want this
                no_gaps_when_only = "true"
            };

            master = {
                # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
                new_is_master = "true"
            };

            # Example windowrules
            windowrule = [
                "float, ^(pavucontrol)$"
                "float, ^(nwg-look)$"
            ];

            ########################################################################################
            # HIDPI FIXES
            ########################################################################################

            # change monitor to high resolution, the last argument is the scale factor
            monitor= ",highres,auto,2"

            # unscale XWayland
            xwayland = {
                force_zero_scaling = "true"
            };

            # toolkit-specific scale
            env = [
                "GDK_SCALE,2"
                "XCURSOR_SIZE,24"
            ];

            ################################
            # MAIN
            ################################

            misc = {
                disable_hyprland_logo = "true"
                vfr = "true"
            };

            exec-once = [
                # Set Status Bar
                "ags"
                # Start Authetication Manager
                "polkit-agent-helper-1"
                "systemctl start --user polkit-gnome-authentication-agent-1"
                # Set cursor
                "hyprctl setcursor Bibata-Modern-Classic 24"
                # set wallpaper daemon
                "sleep 0.5 && swww init"
                # start notification daemon (temporary)
                "mako"

            ];

            exec = [
                # set wallpaper
                "swww img ~/Immagini/Sfondi/For\\\ Her.png"
            ];
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
