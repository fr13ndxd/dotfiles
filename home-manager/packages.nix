{ pkgs, ags, ...}:

{
  home.packages = with pkgs; with nodePackages_latest; [
 # hyprland
 accountsservice
  wezterm
  spotube
 spicetify-cli
 figma-linux

 i2c-tools ddcutil

 obs-studio
 # tools
 bat eza ranger fzf socat jq acpi inotify-tools
 ffmpeg libnotify killall zip unzip glib htop tree

 # langs
 nodejs go sassc typescript meson ninja eslint jdk8

 # other
 gnumake cmake session-desktop hyperfine steam
 vimPlugins.telescope-fzf-native-nvim icon-library
 ibus

 wayland-scanner wl-clipboard
  ];
}
