{ lib, ... }:
  with lib.hm.gvariant; {
    dconf.settings = {
      "org/gnome/desktop/interface" = {
        show-battery-percentage = true;
      };

      "org/gnome/desktop/interface" = {
        # cursor-theme = "catppuccin-mocha-dark-cursors";
      };

      "org/gnome/desktop/peripherals/touchpad" = {
        tap-to-click = true;
        natural-scroll = false;
        two-finger-scrolling-enabled = true;
      };

      "org/gnome/desktop/wm/keybindings" = {
        close = ["<SUPER>q"];
        move-to-workspace-1 = ["<Shift><Super>1"];
        move-to-workspace-2 = ["<Shift><Super>2"];
        move-to-workspace-3 = ["<Shift><Super>3"];
        move-to-workspace-4 = ["<Shift><Super>4"];
        move-to-workspace-5 = ["<Shift><Super>5"];
        switch-to-workspace-1 = ["<Super>F1"];
        switch-to-workspace-2 = ["<Super>F2"];
        switch-to-workspace-3 = ["<Super>F3"];
        switch-to-workspace-4 = ["<Super>F4"];
        switch-to-workspace-5 = ["<Super>F5"];
        toggle-fullscreen = ["<Super>f"];
      };

      "org/gnome/shell/keybindings" = {
        switch-to-application-1 = [];
        switch-to-application-2 = [];
        switch-to-application-3 = [];
        switch-to-application-4 = [];
        switch-to-application-5 = [];
      };

      "org/gnome/desktop/wm/preferences" = {
        mouse-button-modifier = "<Super>";
        num-workspaces = 5;
        resize-with-right-button = true;
        focus-mode = "sloppy";
      };

      "org/gnome/mutter" = {
        dynamic-workspaces = false;
        edge-tiling = true;
        num-workspaces = 5;
        workspaces-only-on-primary = true;
      };

      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
        binding = "<Super>Return";
        command = "wezterm";
        name = "Wezterm";
      };

      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" = {
        binding = "<Super>E";
        command = "nautilus";
        name = "Nautilus";
      };


      "org/gnome/shell" = {
        disable-user-extensions = false;

        enabled-extensions = [
        # user extensions
          "appindicatorsupport@rgcjonas.gmail.com"
          "blur-my-shell@aunetx"
          "caffeine@patapon.info"
          "clipboard-history@alexsaveau.dev"
          "dash-to-dock@micxgx.gmail.com"
          "just-perfection-desktop@just-perfection"
          "quick-settings-tweaks@qwreey"
          "rounded-window-corners@fxgn"
          "unite@hardpixel.eu"
          "Vitals@CoreCoding.com"

        # system extensions
          "apps-menu@gnome-shell-extensions.gcampax.github.com"
          "user-theme@gnome-shell-extensions.gcampax.github.com"
          "places-menu@gnome-shell-extensions.gcampax.github.com"
        ];

        favorite-apps = [
          "brave-browser.desktop"
          "zed.desktop"
          "org.wezfurlong.wezterm.desktop"
          "org.gnome.Nautilus.desktop"
          "org.gnome.Calendar.desktop"
          "transmission-gtk.desktop"
          "discord.desktop"
          "spotify.desktop"
          "org.gnome.Software.desktop"
        ];
      };
    };
  }
