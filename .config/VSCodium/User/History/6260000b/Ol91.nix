
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
        ./hardware/hardware-configuration.nix
        ./os.nix
        ./hardware/video.nix
        ./hardware/audio.nix
        ./hardware/network.nix
        ./user.nix
        ./enviroment.nix
        ./packages.nix
        inputs.home-manager.nixosModules.default
    ];

    # Use Home Manager
    home-manager = {
        # also pass inputs to home-manager modules
        extraSpecialArgs = {inherit inputs;};
        users = {
            "inkeaton" = import ./../home/home.nix;
        };
    };

    # Original system Version
    system.stateVersion = "23.11";  

################################
# PROGRAMS ###############################
################################

    programs = {
    # Zsh
        zsh = {
            enable = true;
            ohMyZsh.enable = true;
            autosuggestions.enable = true;
            syntaxHighlighting.enable = true;
            promptInit = "source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
        };
    };   

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
    # Battery service
        upower.enable = true;
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
