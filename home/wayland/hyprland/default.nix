{ inputs, pkgs, ... }:
let
  nu = "${pkgs.nushell}/bin/nu";
  hyprland = inputs.hyprland.packages.${pkgs.system}.hyprland;
  playerctl = "${pkgs.playerctl}/bin/playerctl";
  pactl = "${pkgs.pulseaudio}/bin/pactl";
  plugins = inputs.hyprland-plugins.packages.${pkgs.system};
  brightnessctl = "${pkgs.brightnessctl}/bin/brightnessctl";
  screenshot = "${import ./scripts/screenshot.nix pkgs}";
in {
  imports = [
    ./statusbar/ags.nix
    ./statusbar/status-bar.nix
    ./binds.nix
    ./settings.nix
    ./hyprlock.nix
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    package = hyprland;
    systemd.enable = true;
    xwayland.enable = true;
    plugins = [ inputs.hyprgrass.packages.${pkgs.system}.default ];

    settings = {
      input = {
        kb_layout = "cz";
        follow_mouse = 1;
        sensitivity = 0;
      };

      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      gestures = { workspace_swipe = "on"; };
      layerrule = [ "ignorealpha 0.01, bar" "blur, bar" ];
      windowrule = let f = regex: "float, ^(${regex})$";
      in [
        "opacity 0.8 0.8, ^(vscode)"
        (f "org.gnome.Calculator")
        (f "org.gnome.Nautilus")
        (f "pavucontrol")
        (f "nm-connection-editor")
        (f "org.gnome.Settings")
        (f "org.gnome.design.Palette")
        (f "Color Picker")
        (f "xdg-desktop-portal")
        (f "xdg-desktop-portal-gnome")
        (f "transmission-gtk")
      ];

    };
  };
}
