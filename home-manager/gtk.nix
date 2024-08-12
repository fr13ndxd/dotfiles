{ pkgs, inputs, ...}:
let
  homeDirectory = "/home/fr13nd";
in
{
  home.packages = [ pkgs.catppuccin-cursors pkgs.catppuccin-gtk pkgs.catppuccin];
  imports = [inputs.catppuccin.homeManagerModules.catppuccin];

  gtk = {
    enable = true;

    cursorTheme = {
      name = "catppuccin-mocha-dark-cursors";
      package = pkgs.catppuccin-cursors.mochaDark;
    };
    iconTheme = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
    };

    theme = {
      name = "adw-gtk3-dark";
      # name="catppuccin-mocha-dark";
      # package=pkgs.catppuccin-gtk;
      package = pkgs.adw-gtk3;
    };
    gtk3.bookmarks = [
      "file://${homeDirectory}/Documents"
      "file://${homeDirectory}/Music"
      "file://${homeDirectory}/Pictures"
      "file://${homeDirectory}/Videos"
      "file://${homeDirectory}/Desktop"
      "file://${homeDirectory}/Downloads"
      "file://${homeDirectory}/.config Config"
      "file://${homeDirectory}/.local/share Local"
    ];
  };
  home.pointerCursor = {
      name = "catppuccin-mocha-dark-cursors";
      package = pkgs.catppuccin-cursors.mochaDark;
      size = 16;
    };
}
