
# 888b    888 d8b           .d88888b.   .d8888b.  
# 8888b   888 Y8P          d88P" "Y88b d88P  Y88b 
# 88888b  888              888     888 Y88b.      
# 888Y88b 888 888 888  888 888     888  "Y888b.   
# 888 Y88b888 888 `Y8bd8P' 888     888     "Y88b. 
# 888  Y88888 888   X88K   888     888       "888 
# 888   Y8888 888 .d8""8b. Y88b. .d88P Y88b  d88P 
# 888    Y888 888 888  888  "Y88888P"   "Y8888P"  
                                                
{ config, pkgs, ... }:

{

################################
# SYSTEM BASICS ##########################
################################
    
    # Hardware scan 
    imports = [./hardware-configuration.nix];

    # Original system Version
    system.stateVersion = "23.11"; 

    # Bootloader 
    boot.loader.systemd-boot.enable         = true;
    boot.loader.efi.canTouchEfiVariables    = false;
    #boot.loader.grub.enable = true;
    #boot.loader.grub.useOSProber = true;
    #boot.loader.grub.copyKernels           = true;
    #boot.loader.grub.efiInstallAsRemovable = true;
    #boot.loader.grub.efiSupport            = true;
    #boot.loader.grub.fsIdentifier          = "label";

    #boot.loader.grub.devices               = [ "nodev" ];
    #boot.loader.grub.extraEntries = ''
    #  menuentry "Reboot" {
    #    reboot
    #  }
    #  menuentry "Poweroff" {
    #    halt
    #  }
    #'';

    # Display Manager
    services.greetd = {enable = true;};
    programs.regreet.enable = true;
    
    # Suspend when lid is closed
    services.logind.lidSwitch = "suspend";

    # Define your hostname.
    networking.hostName = "camilla"; 
    networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

    # Enable networking
    networking.networkmanager.enable = true;

    # Set your time zone.
    time.timeZone = "Europe/Rome";

    # Select internationalisation properties.
    i18n.defaultLocale = "it_IT.UTF-8";

    i18n.extraLocaleSettings = {
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

    # Configure console keymap
    console.keyMap = "it";

    # Configure keymap in X11
    services.xserver = {
        layout = "it";
        xkbVariant = "";
    };

    # Define a user account. Don't forget to set a password with ‘passwd’.
    users.users.inkeaton = {
        isNormalUser = true;
        description = "Edoardo Vassallo";
        extraGroups = [ "networkmanager" "wheel" ];
        packages = with pkgs; [];
    };

################################
# PACKAGES ###############################
################################

    # Allow unfree packages
    nixpkgs.config.allowUnfree = true;
    
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
        krita                        # drwaing app
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
    ];

    # Hyprland
    programs.hyprland = {
        enable = true;
        xwayland.enable = true;
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


    # to install electron
    nixpkgs.config.permittedInsecurePackages = [
            "electron-25.9.0"
            ];

    # to mount from ranger
    services.devmon.enable = true;
    services.udisks2.enable = true;
    services.gvfs.enable = true;

    # PulseAudio
    hardware.pulseaudio.enable = true;
    hardware.pulseaudio.support32Bit = true;    ## If compatibility with 32-bit applications is desired.
    
    # Zsh
    programs.zsh.enable = true;
    users.defaultUserShell = pkgs.zsh;
    programs.zsh.ohMyZsh.enable = true;
    programs.zsh.autosuggestions.enable = true;
    programs.zsh.syntaxHighlighting.enable = true;
    programs.zsh.promptInit = "source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme";

################################
# SERVICES ###############################
################################

    

}
