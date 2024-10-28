{ ... }: {
  wayland.windowManager.hyprland.settings = {
    exec-once = [
      "gsettings set org.gnome.desktop.interface cursor-theme 'catppuccin-mocha-dark-cursors'"
      # "status-bar"
      "ags -b hypr"
    ];

    monitor = [ "eDP-1, 1920x1080@60, 0x0, 1" ];

    misc = {
      disable_splash_rendering = true;
      vfr = true; # nothing happening on screen = less fps = power save
      enable_swallow = true;
    };

    cursor = {
      no_hardware_cursors = true;
      enable_hyprcursor = false;
    };

    decoration = {
      rounding = 11;
      dim_inactive = false; # might change this

      blur = {
        enabled = true;

        size = 1;
        passes = 3;
        new_optimizations = true;
        noise = 0;
        contrast = 0.9;
        brightness = 0.8;
      };
    };
    #   .block {
    # }
    animations = {
      enabled = true;
      # bezier = "animationuwu,  0.99, 1, 0, 0 ";
      bezier = "animationuwu, 0.16, 1, 0.3, 1";
      animation = [
        "windows, 1,5, animationuwu"
        "windowsOut, 1, 10, default, popin 80%"
      ];
    };

    general = {
      layout = "dwindle";
      gaps_in = 8;
      gaps_out = 16;
      border_size = 0;

      allow_tearing = true;
    };

    xwayland.force_zero_scaling = true;
  };
}
