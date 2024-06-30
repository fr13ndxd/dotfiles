# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ inputs, pkgs, config, asztal, lib, ... }:

{
  imports =
    [
        /etc/nixos/hardware-configuration.nix

        ./bootloader.nix
        ./hyprland.nix
    ];

  networking.nameservers = [ "1.1.1.1" "8.8.8.8" ];

  services.ollama = {
    enable = true;
  };

  virtualisation.virtualbox.host.enable = true;
  virtualisation.virtualbox.guest.enable = true;
  nixpkgs.config.virtualbox.host.enableExtensionPack = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

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
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  users.users.fr13nd = {
    isNormalUser = true;
    description = "fr13nd";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      firefox
      brave
      spotify gnomeExtensions.mute-spotify-ads
      gnome-extension-manager

      (zed-editor.overrideAttrs {
        version = "0.141.3";
      })
    #  thunderbird
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  programs.nix-ld.enable = true;

  environment.systemPackages = with pkgs; with gnome; [
    nautilus
    gcc
    clang
    cargo rustfmt rustup rustc pkg-config
    openssl openssl.dev
    dotnet-sdk_8
    accountsservice
    ];

  security = {
    polkit.enable = true;
    pam.services.ags = {};
  };

  services.accounts-daemon.enable = true;

  environment.sessionVariables = {
    DOTNET_ROOT = "${pkgs.dotnet-sdk}";
    OPENSSL_DIR = "${pkgs.openssl}/lib";
  };
  environment.etc."profile.d/pkgconfig-path.sh".text = ''
    export PKG_CONFIG_PATH="$PKG_CONFIG_PATH:${pkgs.openssl.dev}/lib/pkgconfig"
  '';

  system.stateVersion = "23.11"; # Did you read the comment?

}
