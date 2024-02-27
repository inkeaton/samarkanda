{
# Description
    description = "Nixos config flake";

# Input sources
    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

        # home-manager = {
        #   url = "github:nix-community/home-manager";
        #   inputs.nixpkgs.follows = "nixpkgs";
        # };
    };

# Output code
    outputs = { self, nixpkgs, ... }@inputs:
        let
            system = "x86_64-linux";
            pkgs = nixpkgs.legacyPackages.${system};
        in {
        
            nixosConfigurations.default = nixpkgs.lib.nixosSystem {
                specialArgs = {inherit inputs;};
                modules = [ 
                    ./configuration.nix
                    # inputs.home-manager.nixosModules.default
                ];
            };

        };
}
