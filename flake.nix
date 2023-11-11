{
  description = "basic flake";

  inputs = { 
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    ags.url = "github:Aylur/ags/main";
  };

  outputs = { self, nixpkgs, home-manager, ...}@inputs:
    let
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
 
    nixosConfigurations = {
      nixos = lib.nixosSystem {
        inherit system;
        modules = [ ./nixos/configuration.nix ];
      };
    };
    homeConfigurations = {
      fr13nd = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = { inherit inputs; };
        modules = [ ./home-manager/home.nix ];
      };
    };

   nixpkgs.config.allowUnfree = true;
  };

}
