{ pkgs, ags, inputs, ... }: {
  home.packages = with pkgs;
    with nodePackages_latest; [
      telegram-desktop
      gnome-tweaks
      vesktop

      lutris

      inputs.smallfetch.packages.${pkgs.system}.default

      inputs.status-bar.packages.${pkgs.system}.default

      jetbrains.clion

      gtk4
      gtk4-layer-shell
      pkg-config
      hyprlock

      cava
      raylib
      tor-browser

      # (cutter.withPlugins (ps: with ps; [ jsdec rz-ghidra sigdb ]))
      binsider
      imhex
      hexxy

      qemu

      # ghidra
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
