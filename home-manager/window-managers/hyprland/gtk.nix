{ pkgs, ...}:
let
  homeDirectory = "/home/fr13nd";
in
{
  home.packages = [ pkgs.catppuccin-cursors ];

  gtk = {
    enable = true;
    cursorTheme = {
      name = "catppuccin-mocha-dark-cursors";
      package = pkgs.catppuccin-cursors.mochaDark;
    };
    iconTheme = {
      name = "MoreWaita";
      package = pkgs.morewaita-icon-theme;
    };
    theme = {
      name = "adw-gtk3-dark";
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
