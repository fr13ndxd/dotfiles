{ config, pkgs, ... }:

let 
   nerdfonts = (pkgs.nerdfonts.override { fonts = [
   "Ubuntu"
   "UbuntuMono"
   "CascadiaCode"
   "FantasqueSansMono"
   "FiraCode"
   "Mononoki"
   ]; });
in
{
  home.username = "fr13nd";
  home.homeDirectory = "/home/fr13nd";

  imports = [
    ./ags.nix
    ./packages.nix
    ./shell.nix
    ./gtk.nix
    ./home-files.nix
  ];

  nixpkgs.config.allowUnfree = true;
  home.stateVersion = "23.05";

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

  home.packages = with pkgs; [
    telegram-desktop
    neovim

    (pkgs.discord.override {
        withOpenASAR = true;
        withVencord = true;
      })

    # other
    nerdfonts
  ];

  programs.home-manager.enable = true;
}
