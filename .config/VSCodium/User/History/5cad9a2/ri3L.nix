# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  #boot.loader.grub.useOSProber = true;
  boot.loader.systemd-boot.enable         = true;
  boot.loader.efi.canTouchEfiVariables    = false;
  #boot.loader.grub.enable = true;
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

  networking.hostName = "camilla"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

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

  # Configure keymap in X11
  services.xserver = {
    layout = "it";
    xkbVariant = "";
  };

  # Display Manager
  services.greetd = {
  	enable = true;
  };
   
  programs.regreet.enable = true;
  
  # Suspend when lid is closed
  services.logind.lidSwitch = "suspend";
  #programs.xss-lock = {enable = true;};

  # Configure console keymap
  console.keyMap = "it";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.inkeaton = {
    isNormalUser = true;
    description = "Edoardo Vassallo";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  
  # Hyprland
  programs.hyprland = {
	enable = true;
	xwayland.enable = true;
  };
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
     neofetch
     # Shell
     zsh
     oh-my-zsh
     zsh-autosuggestions
     zsh-syntax-highlighting
     zsh-powerlevel10k
     most
     # Git
     gitFull
     # File Manager
     ranger
     # Browser
     firefox
     # File Editor
     gedit
     # Terminal
     kitty
     # Display Manager
     greetd.greetd
     greetd.regreet
     # Wallpaper Daemon
     swww
     # App Launcher (temporary)
     rofi-wayland
     # ls substitute
     eza
     # cat substitute
     bat
     # Code Editor
     vscodium
     # Polkit
     polkit_gnome
     # topbar (temporary)
     eww-wayland
     # audio control
     pamixer
     # brightness control
     brightnessctl
     zip
     p7zip
     gnutar
     rar
     udisks
     usbutils
     udiskie
     python3
     libreoffice
     qbittorrent
     obsidian
     webcord-vencord
     krita
     mpv
     plocate
     nwg-look
     grim
     slurp
     wl-clipboard
     hyprpicker
     yt-dlp
     opentabletdriver
  ];

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


  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

}
