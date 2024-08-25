{ inputs, pkgs, ... }:
let
  hyprland = inputs.hyprland.packages.${pkgs.system}.hyprland;
  playerctl = "${pkgs.playerctl}/bin/playerctl";
  pactl = "${pkgs.pulseaudio}/bin/pactl";
  plugins = inputs.hyprland-plugins.packages.${pkgs.system};
  brightnessctl = "${pkgs.brightnessctl}/bin/brightnessctl";
  screenshot = import ../scripts/screenshot.nix pkgs;
in {
  imports = [ ./ags.nix ];

  wayland.windowManager.hyprland = {
    enable = true;
    package = (hyprland.override { });
    systemd.enable = true;
    xwayland.enable = true;

    settings = {
      exec-once = [ "status-bar" "ags -b hypr" ];

      env = [ "HYPRCURSOR_THEME,catppuccin-mochaDark" "HYPRCURSOR_SIZE,24" ];
      monitor = [ "eDP-1, 1920x1080@500, 0x0, 1" ];
      cursor = { no_hardware_cursors = true; };

      general = {
        layout = "dwindle";
        gaps_in = 8;
        gaps_out = 16;
        border_size = 0;
      };

      decoration = {
        rounding = 11;
        active_opacity = 1;
        inactive_opacity = 1;
        drop_shadow = "yes";
        shadow_range = 8;
        shadow_render_power = 2;
        "col.shadow" = "rgba(00000044)";
        dim_inactive = false;

        blur = {
          enabled = true;
          size = 1;
          passes = 3;
          new_optimizations = "on";
          noise = 0;
          contrast = 0.9;
          brightness = 0.8;
        };
      };

      animations = {
        enabled = "yes";
        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
        animation = [
          "windows, 1, 5, myBezier"
          "windowsOut, 1, 7, default, popin 80%"
          "border, 1, 10, default"
          "fade, 1, 7, default"
          "workspaces, 1, 6, default"
        ];
      };

      misc = {
        disable_splash_rendering = true;
        mouse_move_enables_dpms = true;
        vfr = true;
        enable_swallow = true;
      };

      input = {
        kb_layout = "cz";
        follow_mouse = 1;
        sensitivity = 0;
      };

      dwindle = {
        no_gaps_when_only = false;
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
        ",Print,         exec, ${screenshot}"
        "SHIFT,Print,    exec, ${screenshot} --full"
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
