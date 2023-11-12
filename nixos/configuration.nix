# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      /etc/nixos/hardware-configuration.nix
    ];

  # hyprland
  programs.hyprland = {
    enable = true;
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Prague";
 
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Enable the X11 windowing system.
   services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
   services.xserver.displayManager.gdm = {
    enable = true;
    autoEnable = false;
  };
  # services.xserver.desktopManager.gnome.enable = true;

   xdg.portal = {
     enable = true;
     extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
   };

  # Configure keymap in X11
  services.xserver = {
    layout = "cz";
    xkbVariant = "";
  };

  services.upower.enable = true;

  console.keyMap = "cz-lat2";

  services.printing.enable = true;
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  users.users.fr13nd = {
    isNormalUser = true;
    description = "fr13nd";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      firefox
      gnome.nautilus
    ];
  };


  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    git
    gcc
    clang
    zig
  ];

  system.stateVersion = "23.11"; 

}
