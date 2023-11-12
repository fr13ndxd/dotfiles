{ inputs, pkgs, ... }:
let 
   hyprland = inputs.hyprland.packages.${pkgs.system}.hyprland;
in
{
    wayland.windowManager.hyprland = {
        enable = true;
        package = inputs.hyprland.packages.${pkgs.system}.hyprland;
        systemd.enable = true;
        xwayland.enable = true;

        settings = {
          exec-once = [
            "ags -b hypr"
            "wl-clipboard-history -t"
          ];
        };

        monitor = [
          "eDP-1, 1920x1080@500, 0x0, 1"
        ];

        general = {
          layout = "dwindle";
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

        gestures = {
          workspace_swipe = "on";
        };

        windowrule = let 
            f = regex: "float, ^(${regex})$";
        in [
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
            "blur, ^(bar0)$"
            "ignorealpha 0.4, ^(bar0)$"
        ];

        bind = let
        in 
            binding = mod: cmd: key: arg: "${mod}, ${key}, ${cmd}, ${arg}";
            mvwindow = direction: key: binding "SUPER SHIFT" "movewindow" direction key;
            ws = binding "SUPER" "workspace";
            e = "exec, ags -b hypr";
            arr = [1 2 3 4 5 6 7 8 9];
            mv
        in [
          "CTRL SHIFT, R,         ${e}  quit; ags -b hypr"
          "SUPER, D,              ${e}  -t applauncher"
          ",Print,                ${e}  -r 'recorder.screenshot()'"
          "SHIFT,Print,           ${e}  -r 'recorder.screenshot(true)'"
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

        ]
        ++ (map (i: ws (toString i) (toString i)) arr);
    };
}
