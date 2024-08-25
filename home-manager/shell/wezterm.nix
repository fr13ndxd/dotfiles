{ pkgs, inputs, ... }: {
  home.packages = [ inputs.wezterm-flake.packages.${pkgs.system}.default ];
  xdg.configFile.wezterm.source = ../../wezterm;
}
