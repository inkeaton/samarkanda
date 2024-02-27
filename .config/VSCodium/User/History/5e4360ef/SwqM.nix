

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