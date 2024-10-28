{ pkgs, inputs, ... }: {
  programs.wezterm = {
    enable = true;
    package = pkgs.wezterm;
    extraConfig = ''
      return {
         enable_wayland = false,
         front_end = "WebGpu",

        color_scheme = "Catppuccin Mocha",
        font = require("wezterm").font("CaskaydiaCoveNF"),
        font_size = 9,
        default_cursor_style = "BlinkingBar",

        default_prog = { "nu" },
        -- window_close_confirmation = "NeverPromt",
        hide_tab_bar_if_only_one_tab = true,

        window_padding = {
            top = "0.2cell",
            right = "0.2cell",
            bottom = "0.2cell",
            left = "1cell",
        },

        inactive_pane_hsb = {
            saturation = 0.9;
            brightness = 0.8;
        },

        window_background_opacity = 0.8;
        text_background_opacity = 1.0;
      }
    '';
    # package = inputs.wezterm-flake.packages.${pkgs.system}.default;
    #package = inputs.nixpkgs-stable.legacyPackages."${pkgs.hostPlatform.system}".wezterm;
  };
}
