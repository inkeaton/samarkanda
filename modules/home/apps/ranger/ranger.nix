{ config, pkgs, inputs, ... }:

{
    programs.ranger = {
        enable = true;

        # lines added to rc.conf
        extraConfig = "default_linemode devicons2\n
                       set preview_images true\n
                       set preview_images_method kitty\n";
        # plugins directory
        plugins = [{ name = "ranger_archives";     src = ./plugins/ranger_archives;}
                   { name = "ranger_udisk-menu";   src = ./plugins/ranger_udisk_menu;}
                   { name = "ranger_devicons2";    src = ./plugins/ranger_devicons2;}];
        # Extra commands
        mappings = { ex="extract"; 
                     ec="compress";
        };
    };

    # generate commands.py
    home.file.".config/ranger/commands.py" = {
        enable = true;
        source = ./commands.py;
    };
}