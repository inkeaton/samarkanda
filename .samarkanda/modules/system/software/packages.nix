# 8888888b.                   888                                          
# 888   Y88b                  888                                          
# 888    888                  888                                          
# 888   d88P 8888b.   .d8888b 888  888  8888b.   .d88b.   .d88b.  .d8888b  
# 8888888P"     "88b d88P"    888 .88P     "88b d88P"88b d8P  Y8b 88K      
# 888       .d888888 888      888888K  .d888888 888  888 88888888 "Y8888b. 
# 888       888  888 Y88b.    888 "88b 888  888 Y88b 888 Y8b.          X88 
# 888       "Y888888  "Y8888P 888  888 "Y888888  "Y88888  "Y8888   88888P' 
#                                                    888                   
#                                               Y8b d88P                   
#                                                "Y88P"                     

{ config, lib, pkgs, inputs, ... }:

####################################################
# TO-DO ############################################
####################################################
#   [ ] Use xwayland bridge with discord           #
####################################################

let
    # python and its packages
    python3-with-my-packages =
        pkgs.python3.withPackages (python-packages: with python-packages; [
            numpy               # numbers
            matplotlib          # plot graphs
            pandas              # data manipulation
            notebook            # jupyter notebook
        ]);
    # latex and its packages
    latex-with-my-packages =
        (pkgs.texlive.combine { 
            inherit (pkgs.texlive) scheme-medium 
                cancel 
                psnfss 
                hyperref 
                multirow 
                float 
                wasysym; 
        }); 
in
{
    # Allow unfree packages
    nixpkgs.config.allowUnfree = true;

    # Allow experimental features
    nix.settings.experimental-features = [ "nix-command" "flakes"];

    # Insecure packages allowed
    nixpkgs.config.permittedInsecurePackages = ["electron-25.9.0"]; 

    # Packages
    environment.systemPackages = with pkgs; [

    # SYSTEM ###############################[

        libsForQt5.sddm              # display manager
        where-is-my-sddm-theme       # display manager theme
        polkit_gnome                 # polkit 
        gtk4                         # gtk
        adw-gtk3                     # adwaita theme
        alsa-firmware                # for microphone        (temporary)

    # SHELL ################################[

        zsh                          # shell
        oh-my-zsh                    # shell customizer
        zsh-autosuggestions          # autosuggestions plugin
        zsh-syntax-highlighting      # syntax highlighting plugin
        zsh-powerlevel10k            # shell theme
    
    # TERMINAL APPS ########################[

        most                         # pager                 (less substitute)
        eza                          # directory list        (ls substitute)
        bat                          # display file contents (cat substitute)
        plocate                      # finder
        btop                         # task manager
        neofetch                     # system info utility
        cava                         # audio visualiser
        efibootmgr                   # manage EFI boot entries
        ranger                       # file manager
        gitFull                      # git
        gh                           # github

    # GUI APPS #############################[

        kitty                        # terminal 
        firefox                      # browser
        gedit                        # file editor 
        vscodium                     # code editor
        libreoffice                  # rtf documents editor
        qbittorrent                  # torrent manager
        obsidian                     # notes taking app
        webcord-vencord              # discord
        krita                        # drawing app
        godot_4                      # game engine
        prismlauncher                # minecraft launcher
        mpv                          # video player
        gnome.gnome-font-viewer      # font-viewer
        pavucontrol                  # audio control widget
        kooha                        # screen recording utility
        xorg.xeyes                   # x11 tester
        rofi-wayland                 # app launcher          (temporary)
        rofi-power-menu              # power menu            (temporary)


    # UTILITIES ############################[

        mako                         # notification deamon   (temporary)
        poppler_utils                # For pdf preview
        zip                          # archive managers 
        unzip                        #
        p7zip                        #
        gnutar                       #
        rar                          #
        udisks                       # disks utilities
        usbutils
        udiskie
        swww                         # wallpaper daemon
        pamixer                      # audio control
        brightnessctl                # brightness control 
        mpvScripts.mpris             # mpv MPRIS plugin
        playerctl                    # mpv control MPRIS
        grim                         # screenshot utilities
        slurp                        #
        swappy                       #
        wl-clipboard                 # copy utility
        hyprpicker                   # color picker
        yt-dlp                       # youtube support for mpv
        opentabletdriver             # tablet drivers
        sassc                        # convert css to scss
        upower                       # battery utility
        openssh_hpn                  # ssh
        libnotify                    # provides notify-send
        imv                          # image viewer
        mupdf                        # pdf viewer

    # CODING ##########################[

        python3-with-my-packages     # python3
        latex-with-my-packages       # latex

    ];

    # Zsh configuration
    programs.zsh = {
        enable = true;
        ohMyZsh.enable = true;
        autosuggestions.enable = true;
        syntaxHighlighting.enable = true;
        promptInit = "source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
    };

    # MPV plugins
    nixpkgs.overlays = [
        (self: super: {
            mpv = super.mpv.override {
                scripts = [ self.mpvScripts.mpris ];
            };
        })
    ];
}