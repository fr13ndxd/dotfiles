{ pkgs, ags, inputs, ... }: {
  home.packages = with pkgs;
    with nodePackages_latest; [
      telegram-desktop
      gnome-tweaks
      vesktop

      gtk4
      gtk4-layer-shell
      pkg-config

      cava

      (cutter.withPlugins (ps: with ps; [ jsdec rz-ghidra sigdb ]))
      ghidra
      accountsservice
      spotube
      spicetify-cli
      figma-linux
      ripgrep

      i2c-tools
      ddcutil

      obs-studio
      # tools
      bat
      eza
      ranger
      fzf
      socat
      jq
      acpi
      inotify-tools
      ffmpeg
      libnotify
      killall
      zip
      unzip
      glib
      htop
      tree
      sassc

      # other
      session-desktop
      hyperfine
      steam
      icon-library
      ibus

      wayland-scanner
      wl-clipboard
    ];
}
