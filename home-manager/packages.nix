{ pkgs, ...}:

{
  home.packages = with pkgs; with nodePackages_latest; [
 # hyprland
  wezterm
  wl-gammactl wl-clipboard wf-recorder
  hyprpicker wayshot swappy slurp
  imagemagick pavucontrol brightnessctl swww 

 # tools
 bat eza ranger fd fzf socat jq acpi inotify-tools
 ffmpeg libnotify killall zip unzip glib

 # langs
 nodejs go bun sassc typescript meson ninja eslint

 # other
 gnumake cmake

 grapejuice

  ];
}
