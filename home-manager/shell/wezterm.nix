{pkgs, inputs, ...}: let
  # wez = ''${.wezterm}/bin/wezterm "$@"'';
  # xterm = pkgs.writeShellScriptBin "xterm" wez;
  # kgx = pkgs.writeShellScriptBin "kgx" wez;
in {
#       inputs.nixpkgs-master.legacyPackages."${pkgs.hostPlatform.system}".zed-editor
  home.packages = [
   #   pkgs.wezterm
inputs.wezterm-flake.packages.${pkgs.system}.default
#      inputs.nixpkgs-stable.legacyPackages."${pkgs.hostPlatform.system}".wezterm
    # pkgs.wezterm
    # xterm kgx
  ];
  xdg.configFile.wezterm.source = ../../wezterm;
}
