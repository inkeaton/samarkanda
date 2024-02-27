{ config, lib, pkgs, inputs, ... }:

{
################################
# SERVICES ###############################
################################
    services = {
    # Automount drives
        devmon.enable = true;
        udisks2.enable = true;
        gvfs.enable = true;
    # Suspend when lid is closed (laptop)
        logind.lidSwitch = "suspend";
    # Battery service
        upower.enable = true;
    };
}
