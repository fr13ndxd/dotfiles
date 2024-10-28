{ config, pkgs, inputs, nixpkgs-master, ... }:

let
  nerdfonts = (pkgs.nerdfonts.override {
    fonts = [
      "Ubuntu"
      "UbuntuMono"
      "CascadiaCode"
      "FantasqueSansMono"
      "FiraCode"
      "Mononoki"
    ];
  });

  # font = {
  #   name = "Ubuntu Nerd Font";
  #   package = nerdfonts;
  #   size = 9;
  # };

  iconTheme = {
    name = "MoreWaita";
    package = pkgs.morewaita-icon-theme;
  };
in {
  home.file = {
    ".local/share/fonts" = {
      recursive = true;
      source = "${nerdfonts}/share/fonts/truetype/NerdFonts";
    };
    ".fonts" = {
      recursive = true;
      source = "${nerdfonts}/share/fonts/truetype/NerdFonts";
    };
  };

  gtk = {
    font = {
      name = "Ubuntu Nerd Font";
      package = nerdfonts;
      size = 9;
    };
  };

  home.packages = [ nerdfonts ];
}
