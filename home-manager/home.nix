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
    # window managers
       # hyprland
       ./window-managers/hyprland/hyprland.nix
       ./window-managers/hyprland/ags.nix
       ./window-managers/hyprland/gtk.nix
       # gnome
       ./window-managers/gnome/gnome.nix

    # shell
      ./shell/shell.nix
      ./shell/starship.nix
      ./shell/tmux.nix
      ./shell/wezterm.nix

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
    gnome.gnome-tweaks
    # neovim
  #  moreWaita

   (pkgs.discord.override {
  withOpenASAR = true;
  withVencord = true;
  vencord = pkgs.vencord.overrideAttrs {
    src = pkgs.fetchFromGitHub {
      owner = "Vendicated";
      repo = "Vencord";
      rev = "d19b0aeb5be368689c0e81de3a1c014326146840";
      hash = "sha256-krIXQiAmiXrqrGHeBzc0rKvp/OaT1W7xTyWqt0NUHMU=";
    };
  };
})

    # other
    nerdfonts
  ];

  programs.home-manager.enable = true;
}
