{ pkgs, ags, ...}:

{
  home.packages = with pkgs; with nodePackages_latest; [
 # hyprland
 accountsservice
  wezterm

 # tools
 bat eza ranger fd fzf socat jq acpi inotify-tools
 ffmpeg libnotify killall zip unzip glib htop tree

 # langs
 nodejs go bun sassc typescript meson ninja eslint jdk8

 # other
 gnumake cmake session-desktop hyperfine steam
 vimPlugins.telescope-fzf-native-nvim icon-library

 wayland-scanner wl-clipboard hyprshot
  ];
}
