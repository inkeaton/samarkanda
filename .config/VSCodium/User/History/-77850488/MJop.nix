{ config, lib, pkgs, inputs, ... }

{
    #Bootloader 
    boot.loader = {
        systemd-boot.enable       = true;
        efi.canTouchEfiVariables  = false;
        # grub = {
        #     enable              = true;
        #     useOSProber         = true;
        #     copyKernels         = true;
        #     efiSupport          = true;
        #     fsIdentifier        = "label";
        #     devices             = [ "nodev" ];
        #     extraEntries = ''
        #         menuentry "Reboot" {
        #             reboot
        #         }
        #         menuentry "Poweroff" {
        #             halt
        #         }
        #     '';
        # };
    };

    # Display Manager
    services.xserver.displayManager.sddm = {
        enable = true;
        enableHidpi = true;
        theme = "where_is_my_sddm_theme";
    };


    # Polkit
    systemd = {
        user.services.polkit-gnome-authentication-agent-1 = {
            description = "polkit-gnome-authentication-agent-1";
            wantedBy = [ "graphical-session.target" ];
            wants = [ "graphical-session.target" ];
            after = [ "graphical-session.target" ];
            serviceConfig = {
                Type = "simple";
                ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
                Restart = "on-failure";
                RestartSec = 1;
                TimeoutStopSec = 10;
            };
        };
    };
    security.polkit.enable = true;

    programs.hyprland = {
        enable = true;
        xwayland.enable = true;
        package = inputs.hyprland.packages."${pkgs.system}".hyprland;
    };
}