

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