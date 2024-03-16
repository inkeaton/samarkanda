{ config, pkgs, inputs, ... }:

{
    home.file.".config/swappy/config" = {
        enable = true;
        source = ./config;
    };
}