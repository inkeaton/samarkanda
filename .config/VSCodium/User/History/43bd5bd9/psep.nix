{ config, lib, pkgs, inputs, ... }

{
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
}