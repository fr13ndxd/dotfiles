{ pkgs, inputs, ... }: let
  zed-fhs = pkgs.buildFHSUserEnv {
    name = "zed";
    targetPkgs = pkgs:
      [
         inputs.nixpkgs-master.legacyPackages."${pkgs.hostPlatform.system}".zed-editor
      ];
    runScript = "zed";
  };
in
{
    home.packages =  [
        # pkgs.zed-editor
    # inputs.nixpkgs-master.legacyPackages."${pkgs.hostPlatform.system}".zed-editor

        # zed-fhs
    ];
}
