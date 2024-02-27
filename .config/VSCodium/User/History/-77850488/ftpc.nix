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
}