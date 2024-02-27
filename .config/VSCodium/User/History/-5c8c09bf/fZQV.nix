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

{
####################################################
# TO-DO ############################################
####################################################
#   [ ] Use Grub or ReFIND instead of systemd-boot #
####################################################

    # Allow unfree packages
    nixpkgs.config.allowUnfree = true;

    # Allow experimental features
    nix.settings.experimental-features = [ "nix-command" "flakes"];

    # Insecure packages allowed
    nixpkgs.config.permittedInsecurePackages = ["electron-25.9.0"]; 

    # Packages
    environment.systemPackages = with pkgs; [
        zsh                          # Shell
        oh-my-zsh
        zsh-autosuggestions
        zsh-syntax-highlighting
        zsh-powerlevel10k
        most
        gitFull                      # Git
        gh                           # Github
        ranger                       # File Manager
        firefox                      # Browser
        gedit                        # File Editor 
        kitty                        # Terminal 
        #greetd.greetd                # Display Manager
        #greetd.regreet               #
        swww                         # Wallpaper Daemon
        rofi-wayland                 # App Launcher (temporary)
        eza                          # ls substitute
        bat                          # cat substitute
        vscodium                     # Code Editor
        polkit_gnome                 # Polkit 
        pamixer                      # audio control
        brightnessctl                # brightness control 
        zip                          # Archive managers 
        unzip                        #
        p7zip                        #
        gnutar                       #
        rar                          #
        udisks                       # disks utilities
        usbutils
        udiskie
        python3                      # python3
        libreoffice                  # rich text documents editor
        qbittorrent                  # torrent manager
        obsidian                     # notes taking app
        webcord-vencord              # discord
        krita                        # drawing app
        prismlauncher                # minecraft launcher
        mpv                          # video player
        mpvScripts.mpris             # MPRIS plugin
        playerctl                    # to control MPRIS
        plocate                      # finder
        gnome.gnome-font-viewer      # font-viewer
        grim                         # screenshot utilities
        slurp
        swappy
        wl-clipboard                 # copy utility
        hyprpicker                   # color picker
        yt-dlp                       # YouTube support for mpv
        opentabletdriver             # tablet drivers
        neofetch                     # system info utility
        cava                         # audio visualiser
        sassc                        # convert css to scss
        upower                       # battery utility
        gtk4                         # gtk
        xorg.xeyes                   # check if something is running on X11
        openssh_hpn                  # ssh
        mako                         # Notification (temporary)
        libnotify                    # Provides notify-send
        imv                          # image viewer
        mupdf                        # pdf viewer
        rofi-power-menu              # (temporary)
        efibootmgr                   # manage EFI boot entries
        #lshw                         # see hw info
        #mesa-demos                   # to test nvidia PRIME
        btop                          # task manager
        libsForQt5.sddm              
        where-is-my-sddm-theme       
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