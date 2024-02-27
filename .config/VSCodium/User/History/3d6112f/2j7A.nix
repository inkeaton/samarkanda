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
