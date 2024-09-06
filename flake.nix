{
  description = "basic flake";

  inputs = {
    # nixpkgs
    nixpkgs.url = "nixpkgs/nixos-unstable";
    # nixpkgs-unstable.url = "nixpkgs/nixpkgs-unstable";
    # nixpkgs-stable.url = "nixpkgs/nixos-24.05";
    # nixpkgs-staging.url = "nixpkgs/staging-next"; # for latest zed-editor
    nixpkgs-master.url = "nixpkgs/master";

    ags.url = "github:Aylur/ags";
    status-bar.url = "github:fr13ndxd/status-bar";

    binary-ninja.url = "github:jchv/nix-binary-ninja";
    wezterm-flake = {
      url = "github:wez/wezterm/main?dir=nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    helix-master = {
      url = "github:SoraTenshi/helix/new-daily-driver";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    catppuccin.url = "github:catppuccin/nix";
    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    zig.url = "github:mitchellh/zig-overlay";
    zls-master = { url = "github:zigtools/zls"; };
  };

  outputs = { self, nixpkgs, home-manager, catppuccin, zls-master, zig
    , binary-ninja, helix-master, ... }@inputs:
    let
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      nixosConfigurations = {
        nixos = lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs; };
          modules = [
            ./nixos/configuration.nix

            { nixpkgs.overlays = [ zig.overlays.default ]; }
            catppuccin.nixosModules.catppuccin
          ];
        };
      };

      nixpkgs.config.allowUnfree = true;
    };

}
