
{ config, pkgs, inputs, ... }:

{
    wayland.windowManager.hyprland = {
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
        };
    };
    
}