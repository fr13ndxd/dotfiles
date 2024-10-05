{ inputs, pkgs, config, ... }:

{
  # Enable the GNOME Desktop Environment.
  services.xserver.enable = true;
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
}
