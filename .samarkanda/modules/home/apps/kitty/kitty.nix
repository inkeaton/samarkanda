{ config, pkgs, inputs, ... }:

{
    # programs.kitty = {
    #     enable = true;
    #     font = {
    #         name = "SauceCodePro Nerd Font Mono";
    #         size = 13;
    #     };
    #     extraConfig = "include colors/swingin-through-midtown.conf\n";
    #     # settings = {
    #     #     cursor = "none";
    #     #     cursor_text_color = "background";
    #     #     cursor_shape = "block"; 
    #     #     cursor_beam_thickness = "1.5";
    #     #     cursor_underline_thickness = "2.0";
    #     #     window_padding_width = 7;
    #     #     window_margin_width = 0;
    #     # };
    # };

    home.file.".config/kitty" = {
        enable = true;
        recursive = true;
        source = ./kitty;
    };
}