
# 888b    888 d8b           .d88888b.   .d8888b.  
# 8888b   888 Y8P          d88P" "Y88b d88P  Y88b 
# 88888b  888              888     888 Y88b.      
# 888Y88b 888 888 888  888 888     888  "Y888b.   
# 888 Y88b888 888 `Y8bd8P' 888     888     "Y88b. 
# 888  Y88888 888   X88K   888     888       "888 
# 888   Y8888 888 .d8""8b. Y88b. .d88P Y88b  d88P 
# 888    Y888 888 888  888  "Y88888P"   "Y8888P"  
                                                
{ config, lib, pkgs, inputs, ... }:

{

####################################################
# TO-DO ############################################
####################################################
#   [ ] Use Grub or ReFIND instead of systemd-boot #
#   [x] use SDDM and theme it                      #
#       [x] fix SDDM delay                         #
#   [x] Reorganize file structure                  #
#   [ ] Unite dotfiles with nixOS home manager     #
#   [ ] Move everything in ~/.samarkanda/          #
####################################################

################################
# SYSTEM BASICS ##########################
################################
    
    # Hardware scan 
    imports = [
        ./hardware-configuration.nix
        ./packages.nix
        ./user.nix
        inputs.home-manager.nixosModules.default
    ];

    # Original system Version
    system.stateVersion = "23.11"; 

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
    
    # Polkit
    systemd = {
        user.services.polkit-gnome-authentication-agent-1 = {
            description = "polkit-gnome-authentication-agent-1";
            wantedBy = [ "graphical-session.target" ];
            wants = [ "graphical-session.target" ];
            after = [ "graphical-session.target" ];
            serviceConfig = {
                Type = "simple";
                ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
                Restart = "on-failure";
                RestartSec = 1;
                TimeoutStopSec = 10;
            };
        };
    };
    security.polkit.enable = true;

    # Networking
    networking = {
        # Define your hostname.
        hostName = "camilla"; 
        # Enable networking
        networkmanager.enable = true;
        # custom DNS
        nameservers = [ "1.1.1.1" "1.0.0.1" ];
        networkmanager.insertNameservers = [ "1.1.1.1" "1.0.0.1" ];
    };

    # Audio
    sound.enable = true;
    hardware.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
        jack.enable = true;
    };

    # Video
    hardware = {
        # Opengl
        opengl= {
            enable = true;
            driSupport = true;
            driSupport32Bit = true;
        };   

        # Nvidia config
        nvidia = {
            # Modesetting is required.
            modesetting.enable = true;

            # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
            powerManagement.enable = false;
            # Fine-grained power management. Turns off GPU when not in use.
            # Experimental and only works on modern Nvidia GPUs (Turing or newer).
            powerManagement.finegrained = false;

            # Use the NVidia open source kernel module (not to be confused with the
            # independent third-party "nouveau" open source driver).
            # Support is limited to the Turing and later architectures. Full list of 
            # supported GPUs is at: 
            # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus 
            # Only available from driver 515.43.04+
            # Currently alpha-quality/buggy, so false is currently the recommended setting.
            open = false;

            # Enable the Nvidia settings menu,
            # accessible via `nvidia-settings`.
            nvidiaSettings = true;

            # Optionally, you may need to select the appropriate driver version for your specific GPU.
            package = config.boot.kernelPackages.nvidiaPackages.stable;

            # To use secondary GPU offloading (NVIDIA Prime)
            prime = {
                # Make sure to use the correct Bus ID values for your system!
                # visible with sudo lshw -c display, convert to decimal
                intelBusId = "PCI:0:2:0";
                nvidiaBusId = "PCI:1:0:0";
                offload = {
                    enable = true;
                    enableOffloadCmd = true;
                };
            };
        };
    };

################################
# PROGRAMS ###############################
################################

    programs = {
    # Hyprland 
        hyprland = {
            enable = true;
            xwayland.enable = true;
            package = inputs.hyprland.packages."${pkgs.system}".hyprland;
        };
    # Zsh
        zsh = {
            enable = true;
            ohMyZsh.enable = true;
            autosuggestions.enable = true;
            syntaxHighlighting.enable = true;
            promptInit = "source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
        };
    };   

    # Session Variables
    environment.sessionVariables = rec {
        # If your cursor becomes invisible
        WLR_NO_HARDWARE_CURSORS = "1";
        # Hint electron apps to use wayland
        NIXOS_OZONE_WL = "1";
        EDITOR =         "nano";
        VISUAL =         "codium";
        BROWSER =        "firefox";
        XDG_DESKTOP_DIR="$HOME/";
        XDG_DOCUMENTS_DIR="$HOME/Documenti";
        XDG_DOWNLOAD_DIR="$HOME/Scaricati";
        XDG_MUSIC_DIR="$HOME/Musica";
        XDG_GAMES_DIR="$HOME/Giochi";
        XDG_PICTURES_DIR="$HOME/Immagini";
        XDG_WALLPAPERS_DIR="$HOME/Immagini/Sfondi";
        XDG_SCREENSHOTS_DIR="$HOME/Immagini/Schermate";
        XDG_PUBLICSHARE_DIR="$HOME/";
        XDG_TEMPLATES_DIR="$HOME/";
        XDG_VIDEOS_DIR="$HOME/Video";
    };

    # MPV plugins
    nixpkgs.overlays = [
        (self: super: {
            mpv = super.mpv.override {
                scripts = [ self.mpvScripts.mpris ];
            };
        })
    ];

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
    # Configure keymap in X11
        xserver = {
            layout = "it";
            xkbVariant = "";
            # Load nvidia driver for Xorg and Wayland
            videoDrivers = ["nvidia"];  
            enable = true;
            displayManager.sddm = {
                enable = true;
                enableHidpi = true;
                theme = "where_is_my_sddm_theme";
            };
        };
    # Battery service
        upower.enable = true;
    };

################################
# HOME MANAGER ###########################
################################

    home-manager = {
        # also pass inputs to home-manager modules
        extraSpecialArgs = {inherit inputs;};
        users = {
            "inkeaton" = import ./../home/home.nix;
        };
    };

}

#⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣀⣀⣀⣀⣀⣀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
#⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠛⢿⣿⣿⣿⣷⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
#⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⣿⣿⣿⣿⣷⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀  ######################
#⠀⠀⠀⠀⠀⠀⣠⣄⡀⠀⠀⠀⠀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
#⠀⠀⠀⠀⣠⣾⣿⣿⣿⠖⢀⣼⣆⠈⠻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣆⠀⢲⣶⣶⣶⣶⣄⠀⠀⠀⠀  STRETTA È LA FOGLIA 
#⠀⠀⠠⠞⠛⠛⠿⣿⠏⢀⣾⣿⣿⣷⣄⠀⢤⣤⣤⣤⣤⣤⣤⣤⣤⡄⠙⣿⣿⣧⠀⢻⣿⣿⣿⣿⡆⠀⠀⠀
#⠀⠀⠀⠀⠀⠀⠀⠈⢀⣾⣿⣿⣿⣿⣿⣷⡄⠙⠛⠛⠛⠛⠻⣿⣿⣿⣆⠈⢿⣿⣧⡀⠻⣿⣿⠟⠁⠀⠀⠀  LARGA È LA VIA
#⠀⠀⠀⠀⠀⠀⠀⢠⣿⣿⣿⣿⣿⣿⣿⠿⠁⣠⡀⠰⣶⣶⣆⠈⠻⣿⣿⣦⠈⢻⣿⣷⡀⠙⠁⠀⠀⠀⠀⠀
#⠀⠀⠀⠀⠀⠀⠀⠛⠋⠉⢉⣁⣀⣠⣤⣄⠘⢿⣿⣦⣤⣀⣀⠁⢀⣈⡉⠉⠁⠀⠙⠛⠓⠀⠀⠀⠀⠀⠀⠀  VOI DITE LA VOSTRA 
#⠀⠀⠀⠀⠀⠀⠀⠻⣿⣿⣿⣿⣿⣿⣿⣿⣧⠈⠛⠛⠛⠛⠁⣴⣿⣿⣿⣿⣿⣿⣿⣿⠖⠀⠀⠀⠀⠀⠀⠀
#⠀⠀⠀⠀⠀⠀⢠⡄⠙⢿⣿⣿⣿⣿⣿⠟⠁⣴⣿⣿⣿⣿⣦⠈⠻⣿⣿⣿⣿⣿⡿⠋⢠⣾⣶⣄⠀⠀⠀⠀  CH'IO HO DETTO LA MIA   
#⠀⠀⠀⠀⠀⢰⣿⣿⣦⡀⠻⣿⣿⡿⠋⣠⣾⣿⣿⣿⣿⣿⣿⣷⣄⠙⢿⣿⣿⠟⠁⠐⢿⣿⣿⣿⣷⠀⠀⠀
#⠀⠀⠀⠀⠐⠋⠉⠉⠉⠀⠀⠘⠏⢀⣼⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣦⡀⠻⠋⠀⠀⠀⠀⠙⣿⣿⠃⠀⠀⠀  ######################
#⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣤⣤⣤⣤⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡿⠁⠀⠀⠀⠀
#⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⣿⣿⣿⣧⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠁⠀⠀⠀⠀⠀  inkeaton
#⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣴⡿⠿⠿⠛⠛⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
#⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
