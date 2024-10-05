{ pkgs, ... }:
let
  playerctl = "${pkgs.playerctl}/bin/playerctl";
  pactl = "${pkgs.pulseaudio}/bin/pactl";
  brightnessctl = "${pkgs.brightnessctl}/bin/brightnessctl";
  screenshot = "${import ./scripts/screenshot.nix pkgs}";
in {
  wayland.windowManager.hyprland.settings = {
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
      ",Print,         exec,  ${screenshot}"
      "SHIFT,Print,    exec,  ${screenshot} -f"
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

    # "plugin:touch_gestures" = {
    #   sensitivity = 8.0;
    #   workspace_swipe_fingers = 3;
    #   long_press_delay = 400;
    #   edge_margin = 16;
    #   hyprgrass-bind = [
    #     ", edge:r:l, workspace, +1"
    #     ", edge:l:r, workspace, -1"
    #     '', edge:d:u, exec, notify-send "BAAAH"''
    #   ];
    # };
  };
}
