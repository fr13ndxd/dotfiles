{ inputs, pkgs, ... }:
let username = "fr13nd";
in {
  imports = [
    /etc/nixos/hardware-configuration.nix

    <home-manager/nixos>

    ../modules/gnome.nix
    ../modules/bootloader.nix

    ./hyprland.nix
  ];
  hardware.graphics.enable = true;
  hardware.graphics.enable32Bit = true;
  # hardware.pulseaudio.enable32Bit = true;
  home-manager = {
    backupFileExtension = "backup";
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs; };
    users.${username} = {
      home.username = username;
      home.homeDirectory = "/home/${username}";
      imports = [
        ../home/development
        ../home/editors
        ../home/wayland
        ../home/wezterm
        ../home/kitty
        ../home/cli-tools
        # ../home/firefox

        ../home/fonts.nix

        # currently doesnt build :(
        ../home/binary-ninja.nix

        ../home/gtk.nix

        ../home/shell/shell.nix

        ../home/packages.nix
        ../home/home-files.nix
      ];
      home.stateVersion = "24.05";
    };
  };

  networking.nameservers = [ "1.1.1.1" "8.8.8.8" ];

  nixpkgs.config.permittedInsecurePackages = [ "olm-3.2.16" ];

  virtualisation.virtualbox.host.enable = true;
  virtualisation.virtualbox.guest.enable = true;
  nixpkgs.config.virtualbox.host.enableExtensionPack = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  networking.networkmanager.enable = true;
  networking.hostName = "nixos"; # Define your hostname.

  # Set your time zone.
  time.timeZone = "Europe/Prague";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "cs_CZ.UTF-8";
    LC_IDENTIFICATION = "cs_CZ.UTF-8";
    LC_MEASUREMENT = "cs_CZ.UTF-8";
    LC_MONETARY = "cs_CZ.UTF-8";
    LC_NAME = "cs_CZ.UTF-8";
    LC_NUMERIC = "cs_CZ.UTF-8";
    LC_PAPER = "cs_CZ.UTF-8";
    LC_TELEPHONE = "cs_CZ.UTF-8";
    LC_TIME = "cs_CZ.UTF-8";
  };

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    alsa-lib
    at-spi2-atk
    at-spi2-core
    atk
    cairo
    cups
    curl
    dbus
    expat
    fontconfig
    freetype
    fuse3
    gdk-pixbuf
    glib
    gtk3
    icu
    libGL
    libappindicator-gtk3
    libdrm
    libglvnd
    libnotify
    libpulseaudio
    libunwind
    libusb1
    libuuid
    libxkbcommon
    libxml2
    mesa
    nspr
    nss
    openssl
    pango
    pipewire
    stdenv.cc.cc
    systemd
    vulkan-loader
    xorg.libX11
    xorg.libXScrnSaver
    xorg.libXcomposite
    xorg.libXcursor
    xorg.libXdamage
    xorg.libXext
    xorg.libXfixes
    xorg.libXi
    xorg.libXrandr
    xorg.libXrender
    xorg.libXtst
    xorg.libxcb
    xorg.libxkbfile
    xorg.libxshmfence
    zlib
  ];
  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "cz";
    variant = "";
  };
  services.flatpak.enable = true;

  programs.wireshark = {
    enable = true;
    package = pkgs.wireshark;
  };

  # Configure console keymap
  console.keyMap = "cz-lat2";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
  services.ollama.enable = true;

  users.users.fr13nd = {
    isNormalUser = true;
    description = "fr13nd";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      firefox
      brave
      # wineWowPackages.stable
      # winetricks
      spotify
      gnomeExtensions.mute-spotify-ads
      gnome-extension-manager
      nautilus
      hyprshade
      zed-editor
    ];
  };

  nixpkgs.config = { allowUnfree = true; };
  environment.systemPackages = with pkgs; [
    clang
    pkgs.zigpkgs.master
    inputs.zls-master.packages.${system}.default
    rustfmt
    rustup
    openssl
    openssl.dev
    dotnet-sdk_8
    accountsservice

    direnv

    qemu

    networkmanager
  ];

  services.accounts-daemon.enable = true;
  system.stateVersion = "24.05";
}
