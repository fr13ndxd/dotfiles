{ pkgs, ags, inputs, ... }: {
  programs.lazygit = {
    enable = true;
    settings = {
      gui = {
        nerdFontsVersion = "3";
        border = "rounded";
        showBottomLine = false;
      };
    };
  };
}
