{ inputs, pkgs, ... }:
let
  nu = "${pkgs.nushell}/bin/nu";
  hyprland = inputs.hyprland.packages.${pkgs.system}.hyprland;
  playerctl = "${pkgs.playerctl}/bin/playerctl";
  pactl = "${pkgs.pulseaudio}/bin/pactl";
  plugins = inputs.hyprland-plugins.packages.${pkgs.system};
  brightnessctl = "${pkgs.brightnessctl}/bin/brightnessctl";
  screenshot = "${import ./scripts/screenshot.nix pkgs}/bin/screenshot";
in {
  imports = [
    ./statusbar/ags.nix
    ./statusbar/status-bar.nix
    # ./binds.nix
    ./settings.nix
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    package = (hyprland.override { });
    systemd.enable = true;
    xwayland.enable = true;

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

      bind = let
        binding = mod: cmd: key: arg: "${mod}, ${key}, ${cmd}, ${arg}";
        mvwindow = direction: key:
          binding "SUPER SHIFT" "movewindow" direction key;
        resizeactive = binding "SUPER CTRL" "resizeactive";
        ws = binding "SUPER" "workspace";
        e = "exec, ags -b hypr";
        arr = [ 1 2 3 4 5 6 7 8 9 ];
      in [
        "CTRL SHIFT, R,         ${e}  quit; ags -b hypr"
        "CTRL SHIFT, R,         exec, pkill status-bar; status-bar"
        "SUPER, D,              ${e}  -t launcher"
        ",Print,         exec, ${nu} ${screenshot}"
        "SHIFT,Print,    exec, ${nu} ${screenshot} -f"
        "CTRL SHIFT,Print,      ${e}  -r 'recorder.start()'"
        "SUPER, Return, exec, wezterm"
        "SUPER,E, exec, nautilus -w"

        "SUPER,Q, killactive"
        "SUPER,F, fullscreen"
        "SUPER,Space, togglefloating"
        "SUPER,P, pseudo"
        "SUPER,S, togglesplit"

        (mvwindow "left" "l")
        (mvwindow "right" "r")
        (mvwindow "up" "u")
        (mvwindow "down" "d")
        (resizeactive "k" "0 -20")
        (resizeactive "j" "0 20")
        (resizeactive "l" "20 0")
        (resizeactive "h" "-20 0")

      ] ++ (map (i: ws ("F" + toString i) (toString i)) arr);

      bindle = [
        ",XF86MonBrightnessUp,   exec, ${brightnessctl} set +5%"
        ",XF86MonBrightnessDown, exec, ${brightnessctl} set  5%-"
      ];

      bindl = [
        ",XF86AudioPlay,    exec, ${playerctl} play-pause"
        ",XF86AudioStop,    exec, ${playerctl} pause"
        ",XF86AudioPause,   exec, ${playerctl} pause"
        ",XF86AudioPrev,    exec, ${playerctl} previous"
        ",XF86AudioNext,    exec, ${playerctl} next"
        ",XF86AudioMicMute, exec, ${pactl} set-source-mute @DEFAULT_SOURCE@ toggle"
        ",XF86AudioMute,    exec, pactl set-sink-mute @DEFAULT_SINK@ toggle"
        ",XF86AudioRaiseVolume,  exec, ${pactl} set-sink-volume @DEFAULT_SINK@ +5%"
        ",XF86AudioLowerVolume,  exec, ${pactl} set-sink-volume @DEFAULT_SINK@ -5%"
      ];

      bindm = [
        "SUPER, mouse:273, resizewindow"
        "SUPER, mouse:272, movewindow"
        "SUPER, mouse_up, workspace e-1"
        "SUPER, mouse_down, workspace e+1"
      ];
    };
  };
}
