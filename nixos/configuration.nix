# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ inputs, pkgs, config, asztal, lib, catppuccin, ... }:

{
  imports =
    [
        /etc/nixos/hardware-configuration.nix

        ./bootloader.nix
        ./hyprland.nix
    ];

  networking.nameservers = [ "1.1.1.1" "8.8.8.8" ];

  virtualisation.virtualbox.host.enable = true;
  virtualisation.virtualbox.guest.enable = true;
  nixpkgs.config.virtualbox.host.enableExtensionPack = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Prague";

  # Select internationalisation properties.
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

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  environment.gnome.excludePackages = (with pkgs; [
    gnome-console
    gnome-photos
    gnome-tour
    gnome-connections
    snapshot
    gedit
    cheese # webcam tool
    epiphany # web browser
    geary # email reader
    evince # document viewer
    totem # video player
    yelp # Help view
    gnome-font-viewer
  ]) ++ (with pkgs.gnome; [
  gnome-music
  gnome-characters
  tali # poker game
  iagno # go game
  hitori # sudoku game
  atomix # puzzle game
  gnome-contacts
  gnome-initial-setup
  gnome-shell-extensions
  gnome-maps
  ]);

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

  programs.steam.enable = true;
  users.users.fr13nd = {
    isNormalUser = true;
    description = "fr13nd";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      firefox
      brave

      wineWowPackages.stable winetricks

      spotify gnomeExtensions.mute-spotify-ads
      gnome-extension-manager

      nautilus

      # zed-editor
      inputs.nixpkgs-master.legacyPackages."${pkgs.hostPlatform.system}".zed-editor
      # zed-editor
    ];
  };

  nixpkgs.config = {
    allowUnfree = true;
  };

  programs.nix-ld.enable = true;

  environment.systemPackages = with pkgs; [
    gcc
    clang
    rustfmt rustup
    openssl openssl.dev
    dotnet-sdk_8
    accountsservice

    direnv

    networkmanager
  ];

  security = {
    polkit.enable = true;
    pam.services.ags = {};
  };

  services.accounts-daemon.enable = true;

  system.stateVersion = "24.05";

}
