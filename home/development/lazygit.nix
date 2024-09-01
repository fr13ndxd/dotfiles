{ pkgs, ags, inputs, ... }: {
  programs.lazygit = {
    enable = true;
    settings = {
      gui = {
        nerdFontsVersion = "3";
        border = "rounded"; # else "single";
        showBottomLine = false;
      };
    };
  };
}
