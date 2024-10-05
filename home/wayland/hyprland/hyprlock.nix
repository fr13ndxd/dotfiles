{ pkgs, ... }: {
  programs.hyprlock = {
    enable = true;
    settings = {
      general = { hide_cursor = false; };

      background = [{
        path = "screenshot";
        blur_passes = 1;
        blur_size = 3;
      }];

      input-field = [{
        size = "500, 50";
        position = "center, center";
        monitor = "";
        fade_on_empty = false;
        font_color = "rgb(202, 211, 245)";
        inner_color = "rgb(91, 96, 120)";
        outer_color = "rgb(24, 25, 38)";
        outline_thickness = 5;
        placeholder_text = "Password...";
        shadow_passes = 2;
      }];

      # text = Hi there, $USER
      # text_align = center # center/right or any value for default left. multi-line text alignment inside label container
      # color = rgba(200, 200, 200, 1.0)
      # font_size = 25
      # font_family = Noto Sans
      # rotate = 0 # degrees, counter-clockwise
      label = [{
        text = "$USER";
        halign = "center";
        valign = "center";
      }];
    };
  };
}
