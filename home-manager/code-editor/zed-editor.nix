{ pkgs, inputs, ... }:

{
    home.packages =  [
        # pkgs.zed-editor
        # inputs.nixpkgs-stable.legacyPackages."${pkgs.hostPlatform.system}".zed-editor
    ];
}
