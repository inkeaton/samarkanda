# 888b     d888               8888888888 888          888               
# 8888b   d8888               888        888          888               
# 88888b.d88888               888        888          888               
# 888Y88888P888 888  888      8888888    888  8888b.  888  888  .d88b.  
# 888 Y888P 888 888  888      888        888     "88b 888 .88P d8P  Y8b 
# 888  Y8P  888 888  888      888        888 .d888888 888888K  88888888 
# 888   "   888 Y88b 888      888        888 888  888 888 "88b Y8b.     
# 888       888  "Y88888      888        888 "Y888888 888  888  "Y8888  
#                   888                                                
#              Y8b d88P                                                
#               "Y88P"                                                 

{
# Description
    description = "Nixos config flake";

# Input sources
    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

        home-manager = {
           url = "github:nix-community/home-manager";
           inputs.nixpkgs.follows = "nixpkgs";
        };

        # add ags
        ags.url = "github:Aylur/ags";
    };

# Output code
    outputs = { self, home-manager, nixpkgs, ... }@inputs:
        let
            system = "x86_64-linux";
            pkgs = nixpkgs.legacyPackages.${system};

        in 
            {
                nixosConfigurations.default = nixpkgs.lib.nixosSystem {
                    specialArgs = {inherit inputs;};
                    modules = [ 
                        ./modules/system/configuration.nix
                        inputs.home-manager.nixosModules.default
                    ];
                };
        };
}
