

{ config, lib, pkgs, inputs, ... }

{
# User account
    users = {
    # Define a user account.
        users.inkeaton = {
        isNormalUser = true;
        description  = "inkeaton";
        extraGroups  = [ "networkmanager" "wheel" ];
        shell        = pkgs.zsh;
        };
    };

    # Select internationalisation properties.
    i18n = {
        defaultLocale  = "it_IT.UTF-8";
        extraLocaleSettings = {
            LC_ADDRESS        = "it_IT.UTF-8";
            LC_IDENTIFICATION = "it_IT.UTF-8";
            LC_MEASUREMENT    = "it_IT.UTF-8";
            LC_MONETARY       = "it_IT.UTF-8";
            LC_NAME           = "it_IT.UTF-8";
            LC_NUMERIC        = "it_IT.UTF-8";
            LC_PAPER          = "it_IT.UTF-8";
            LC_TELEPHONE      = "it_IT.UTF-8";
            LC_TIME           = "it_IT.UTF-8";
        };
    };

    # Set your time zone.
    time.timeZone  = "Europe/Rome";

    # Configure console keymap
    console.keyMap = "it";

    services.xserver = {
            layout = "it";
            xkbVariant = "";
        };
}
