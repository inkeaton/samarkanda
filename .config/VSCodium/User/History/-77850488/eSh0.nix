{ config, lib, pkgs, inputs, ... }

{
    #Bootloader 
    boot.loader = {
        systemd-boot.enable       = true;
        efi.canTouchEfiVariables  = false;
        # grub = {
        #     enable                = true;
        #     useOSProber           = true;
        #     copyKernels           = true;
        #     efiSupport            = true;
        #     fsIdentifier          = "label";
        #     devices               = [ "nodev" ];
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
}