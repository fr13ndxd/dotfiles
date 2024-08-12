{ config, pkgs, inputs,... }:

let
   nerdfonts = (pkgs.nerdfonts.override { fonts = [
   "Ubuntu"
   "UbuntuMono"
   "CascadiaCode"
   "FantasqueSansMono"
   "FiraCode"
   "Mononoki"
   ]; });

   font = {
     name = "Ubuntu Nerd Font";
     package = nerdfonts;
     size = 9;
   };

   iconTheme = {
     name = "MoreWaita";
     package = pkgs.morewaita-icon-theme;
   };
in
{
  home.username = "fr13nd";
  home.homeDirectory = "/home/fr13nd";

  imports = [
    ./hyprland/hyprland.nix
    ./gnome/gnome.nix

    ./status-bar.nix

    ./gtk.nix

    ./shell/shell.nix

    # code editor
      ./code-editor/vscode.nix
      ./code-editor/zed-editor.nix

    # neovim
      ./nvim/nvim.nix

    # other
     ./packages.nix
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

  gtk = {
    inherit font;
  };

  home.packages = with pkgs; [
    telegram-desktop
    gnome-tweaks

    vesktop

 #  (pkgs.discord.override {
 #     withOpenASAR = true;
 #     withVencord = true;
 #   })

    # other
    nerdfonts
  ];

  programs.home-manager.enable = true;
}
