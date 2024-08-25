{
  description = "basic flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixpkgs-unstable.url = "nixpkgs/nixpkgs-unstable";
    nixpkgs-stable.url = "nixpkgs/nixos-24.05";
    nixpkgs-staging.url = "nixpkgs/staging-next"; # n for latest zed-editor
    nixpkgs-master.url = "nixpkgs/master";

    binary-ninja = {
      url = "github:jchv/nix-binary-ninja";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    wezterm-flake.url = "github:wez/wezterm/main?dir=nix";
    wezterm-flake.inputs.nixpkgs.follows = "nixpkgs";

    catppuccin.url = "github:catppuccin/nix";

    nixos-cosmic = {
        url = "github:lilyinstarlight/nixos-cosmic";
        inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins?submodules=1";
      inputs.hyprland.follows = "hyprland";
    };

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    #matugen.url = "github:InioX/matugen";

    ags.url = "github:Aylur/ags";

    zig.url = "github:mitchellh/zig-overlay";
    zls-master = {
      url = "github:zigtools/zls";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    status-bar.url = "github:fr13ndxd/status-bar";

    more-waita = {
      url = "https://github.com/somepaulo/MoreWaita/archive/refs/heads/main.zip";
      flake = false;
    };
  };

  outputs = { self, zig, nixpkgs, home-manager, catppuccin, nixos-cosmic, zls-master, ...}@inputs:
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
         #  asztal = self.packages.x86_64-linux.default;
        };
        modules = [ ./nixos/configuration.nix
            {nixpkgs.overlays = [zig.overlays.default];}
            catppuccin.nixosModules.catppuccin
            nixos-cosmic.nixosModules.default
        ];
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
