{ config, pkgs, inputs, ... }:

{
    # manage gtk theme
    gtk = {
        enable = true;
        theme = {
            name = "Adwaita-OLED";
        };

        iconTheme = {
            name = "kora";
            package = pkgs.kora-icon-theme;
        };

        font = {
            name = "SF Pro Rounded Regular";
        };
    };
}