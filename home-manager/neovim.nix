{ pkgs, ... }:
{
  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  xdg.desktopEntries."nvim" = {
    name = "NeoVim";
    comment = "Edit text files";
    icon = "nvim";
    # xterm is a symlink and not actually xterm
    # exec = "xterm -e ${pkgs.neovim}/bin/nvim %F";
    exec = "wezterm start --always-new-process ${pkgs.neovim}/bin/nvim";
    categories = [ "TerminalEmulator" ];
    terminal = false;
    mimeType = [ "text/plain" ];
  };

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;

    withRuby = true;
    withNodeJs = true;
    withPython3 = true;

    extraPackages = with pkgs; [
      gnumake
      cargo
      gcc13
      unzip
      wget
      curl
      clang
      clangd
      tree-sitter
      luajitPackages.luarocks
      python311Packages.pynvim
      php82Packages.composer
      python311Packages.pip
    ];
  };

  xdg.configFile.nvim.source = ../nvim;
}
