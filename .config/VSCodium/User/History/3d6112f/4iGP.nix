# 888b    888 d8b           .d88888b.   .d8888b.  
# 8888b   888 Y8P          d88P" "Y88b d88P  Y88b 
# 88888b  888              888     888 Y88b.      
# 888Y88b 888 888 888  888 888     888  "Y888b.   
# 888 Y88b888 888 `Y8bd8P' 888     888     "Y88b. 
# 888  Y88888 888   X88K   888     888       "888 
# 888   Y8888 888 .d8""8b. Y88b. .d88P Y88b  d88P 
# 888    Y888 888 888  888  "Y88888P"   "Y8888P"                                                

{
# Description
    description = "Nixos config flake";

# Input sources
    inputs = {
        # packages channel
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

        # home manager module
        home-manager = {
           url = "github:nix-community/home-manager";
           inputs.nixpkgs.follows = "nixpkgs";
        };

        # ags module
        ags.url = "github:Aylur/ags";

        # Hyprland module
        hyprland.url = "github:hyprwm/Hyprland";
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
                        #inputs.home-manager.nixosModules.default
                        ./home.nix
                    ];
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
#⠀⠀⠀⠀
