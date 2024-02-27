

{ config, pkgs, inputs, ... }:

{
    # Imported modules
    imports = [ 
        # Hyprland config
        ./../hyprland/hyprmain.nix
    ];

    # Configure Hyprland
    wayland.windowManager.hyprland = {
        enable = true;

        settings = {
            ########################################################################################
            # WINDOWS
            ########################################################################################

            general = {
                gaps_in = "5";
                gaps_out = "20";
                border_size = "0";
                "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
                "col.inactive_border" = "rgba(595959aa)";

                layout = "dwindle";
            };

            decoration = {
                # round corners
                rounding = "15";
                # shadows
                drop_shadow = "yes";
                shadow_range = "4";
                shadow_render_power = "3";
                "col.shadow" = "rgba(1a1a1aee)";
                # blur
                blur = {
                    enabled = "yes";
                    new_optimizations = "true";
                    size = "10";
                    passes = "3";
                    xray = "true";
                };
            };

            animations = {
                enabled = "yes";

                bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";

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
                pseudotile = "yes"; # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
                preserve_split = "yes"; # you probably want this
                no_gaps_when_only = "true";
            };

            master = {
                # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
                new_is_master = "true";
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
            monitor= ",highres,auto,2";

            # unscale XWayland
            xwayland = {
                force_zero_scaling = "true";
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
                disable_hyprland_logo = "true";
                vfr = "true";
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
}