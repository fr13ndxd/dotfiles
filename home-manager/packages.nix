{ pkgs, ags, inputs, ...}:
{
  home.packages = with pkgs; with nodePackages_latest; [
    (cutter.withPlugins(ps: with ps; [ jsdec rz-ghidra sigdb ]))
    ghidra
 accountsservice
  spotube
 spicetify-cli
 figma-linux
 ripgrep

 i2c-tools ddcutil

 obs-studio
 # tools
 bat eza ranger fzf socat jq acpi inotify-tools
 ffmpeg libnotify killall zip unzip glib htop tree

 # langs
 nodejs go sassc typescript meson ninja eslint jdk8

 # other
 gnumake cmake session-desktop hyperfine steam
  icon-library
 ibus

 wayland-scanner wl-clipboard
  ];
}
