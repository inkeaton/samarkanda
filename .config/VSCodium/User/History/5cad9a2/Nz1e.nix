
# 888b    888 d8b           .d88888b.   .d8888b.  
# 8888b   888 Y8P          d88P" "Y88b d88P  Y88b 
# 88888b  888              888     888 Y88b.      
# 888Y88b 888 888 888  888 888     888  "Y888b.   
# 888 Y88b888 888 `Y8bd8P' 888     888     "Y88b. 
# 888  Y88888 888   X88K   888     888       "888 
# 888   Y8888 888 .d8""8b. Y88b. .d88P Y88b  d88P 
# 888    Y888 888 888  888  "Y88888P"   "Y8888P"  
                                                
{ config, pkgs, inputs, ... }:

{

################################
# SYSTEM BASICS ##########################
################################
    
    # Hardware scan 
    imports = [
        ./hardware-configuration.nix
        inputs.home-manager.nixosModules.default
    ];

    # Original system Version
    system.stateVersion = "23.11"; 
    
    # User account
    users = {
    # default shell
        defaultUserShell = pkgs.zsh;
    # Define a user account.
        users.inkeaton = {
        isNormalUser = true;
        description = "Edoardo Vassallo";
        extraGroups = [ "networkmanager" "wheel" ];
        packages = with pkgs; [];
        };
    };

    # Select internationalisation properties.
    i18n = {
        defaultLocale = "it_IT.UTF-8";
        extraLocaleSettings = {
            LC_ADDRESS = "it_IT.UTF-8";
            LC_IDENTIFICATION = "it_IT.UTF-8";
            LC_MEASUREMENT = "it_IT.UTF-8";
            LC_MONETARY = "it_IT.UTF-8";
            LC_NAME = "it_IT.UTF-8";
            LC_NUMERIC = "it_IT.UTF-8";
            LC_PAPER = "it_IT.UTF-8";
            LC_TELEPHONE = "it_IT.UTF-8";
            LC_TIME = "it_IT.UTF-8";
        };
    };

    # Set your time zone.
    time.timeZone = "Europe/Rome";

    # Configure console keymap
    console.keyMap = "it";

    # Bootloader 
    boot.loader = {
        systemd-boot.enable       = true;
        efi.canTouchEfiVariables  = false;
    #    grub = {
    #        enable                = true;
    #        useOSProber           = true;
    #        copyKernels           = true;
    #        efiInstallAsRemovable = true;
    #        efiSupport            = true;
    #        fsIdentifier          = "label";
    #        devices               = [ "nodev" ];
    #        extraEntries = ''
    #            menuentry "Reboot" {
    #                reboot
    #            }
    #            menuentry "Poweroff" {
    #                halt
    #            }
    #        '';
    #    };
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
    #hardware.pulseaudio = {
        # enable audio
    #    enable = true;
        # enable 32-bit compatibility
    #    support32Bit = true;    
    #};
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

################################
# PACKAGES ###############################
################################

    # Allow unfree packages
    nixpkgs.config.allowUnfree = true;

    # Allow experimental features
    nix.settings.experimental-features = [ "nix-command" "flakes"];

    # Insecure packages allowed
    nixpkgs.config.permittedInsecurePackages = ["electron-25.9.0"];
    
    # List packages installed in system profile.
    environment.systemPackages = with pkgs; [
        zsh                          # Shell
        oh-my-zsh
        zsh-autosuggestions
        zsh-syntax-highlighting
        zsh-powerlevel10k
        most
        gitFull                      # Git
        ranger                       # File Manager
        firefox                      # Browser
        gedit                        # File Editor 
        kitty                        # Terminal 
        greetd.greetd                # Display Manager
        greetd.regreet               #
        swww                         # Wallpaper Daemon
        rofi-wayland                 # App Launcher (temporary)
        eza                          # ls substitute
        bat                          # cat substitute
        vscodium                     # Code Editor
        polkit_gnome                 # Polkit 
        eww-wayland                  # topbar (temporary) 
        pamixer                      # audio control
        brightnessctl                # brightness control 
        zip                          # Archive managers 
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
        mpv                          # video player
        plocate                      # finder
        nwg-look                     # gtk settings
        grim                         # screenshot utilities
        slurp
        wl-clipboard                 # copy utility
        hyprpicker                   # color picker
        yt-dlp                       # YouTube support for mpv
        opentabletdriver             # tablet drivers
        neofetch                     # system info utility
        cava                         # audio visualiser
    ];    

################################
# PROGRAMS ###############################
################################

    programs = {
    # Hyprland 
        hyprland = {
            enable = true;
            xwayland.enable = true;
        };
    # Zsh
        zsh = {
            enable = true;
            ohMyZsh.enable = true;
            autosuggestions.enable = true;
            syntaxHighlighting.enable = true;
            promptInit = "source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
        };
    # Display manager
        regreet.enable = true;
    };

################################
# SERVICES ###############################
################################

    services = {
    # Enable greetd display manager
        greetd.enable = true;
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
        };
    };

################################
# HOME MANAGER ###########################
################################


    home-manager = {
        # also pass inputs to home-manager modules
        extraSpecialArgs = {inherit inputs;};
        users = {
            "inkeaton" = import ./home.nix;
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
