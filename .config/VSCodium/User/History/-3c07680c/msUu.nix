
{ config, pkgs, inputs, ... }:

{
    wayland.windowManager.hyprland = {
        settings = {
            ########################################################################################
            # BINDINGS
            ########################################################################################
            "$mainMod" = "SUPER";

            bind = [ 
                # Brightness keybinds (with AGS)
                ", XF86MonBrightnessUp,     exec, ags --run-js \"brightness.screen_value += 0.05\""
                ", XF86MonBrightnessDown,   exec, ags --run-js \"brightness.screen_value -= 0.05\""

                # Volume Keybinds
                ", XF86AudioRaiseVolume,    exec, pamixer -i 5"
                ", XF86AudioLowerVolume,    exec, pamixer -d 5"
                ", XF86AudioMute,           exec, pamixer -t"
                ", XF86AudioMicMute,        exec, pamixer --default-source -t"

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
                ", Print,                   exec, ~/.config/nixos/scripts/screenshot.sh sc"
                "SUPER, Print,              exec, ~/.config/nixos/scripts/screenshot.sh sf"
                "CTRL, Print,               exec, ~/.config/nixos/scripts/screenshot.sh si"
                "SHIFT, Print,              exec, ~/.config/nixos/scripts/screenshot.sh rc"
                "SUPER SHIFT, Print,        exec, ~/.config/nixos/scripts/screenshot.sh rf"
                "CTRL SHIFT, Print,         exec, ~/.config/nixos/scripts/screenshot.sh ri"

                # Screen recorder
                "ALT, Print,                exec, ~/.config/nixos/scripts/screenshot.sh sc"

                # Color picker
                "SUPER, C,                  exec, ~/.config/nixos/scripts/screenshot.sh p"

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
                workspace_swipe = "on";
            };

            input = {
                kb_layout = "it";
                follow_mouse = "1";

                touchpad = {
                    natural_scroll = "yes";
                };

                sensitivity = "0";
            };
        };
    };
    
}