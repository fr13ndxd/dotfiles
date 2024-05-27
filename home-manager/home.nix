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
in
{
  home.username = "fr13nd";
  home.homeDirectory = "/home/fr13nd";

  imports = [
     # hyprland
      ./hyprland/hyprland.nix
      ./hyprland/ags.nix
      ./hyprland/gtk.nix

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

  home.packages = with pkgs; [
    telegram-desktop
    # neovim
  #  moreWaita

    (pkgs.discord.override {
        withOpenASAR = true;
        withVencord = true;
      })

    # other
    nerdfonts
  ];

  programs.home-manager.enable = true;
}
