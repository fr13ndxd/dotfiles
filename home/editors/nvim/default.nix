{ inputs, pkgs, ... }: {
  # TODO: make config uwu
  home.packages = [ ];
  programs.neovim = {
    enable = true;
    vimAlias = true;
    viAlias = true;
    vimdiffAlias = true;

    plugins = [ ];
  };
}
