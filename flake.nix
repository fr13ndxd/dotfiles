{
  description = "basic flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";

    # fix hyprland build error:
    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1"; #&ref=xwayland-rewrite";

    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins?submodules=1";
      inputs.hyprland.follows = "hyprland";
    };

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # matugen.url = "github:InioX/matugen";
    matugen.url = "github:InioX/matugen?ref=v2.2.0";

    ags.url = "github:Aylur/ags";
    astal.url = "github:Aylur/astal";

    more-waita = {
      url = "https://github.com/somepaulo/MoreWaita/archive/refs/heads/main.zip";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, home-manager, ...}@inputs:
    let
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
    packages.x86_64-linux.default = nixpkgs.legacyPackages.x86_64-linux.callPackage ./ags {inherit inputs;};
    nixosConfigurations = {
      nixos = lib.nixosSystem {
        inherit system;
        specialArgs = {
          inherit inputs;
          asztal = self.packages.x86_64-linux.default;
        };
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
