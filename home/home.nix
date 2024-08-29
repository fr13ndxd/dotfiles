{ config, pkgs, inputs, nixpkgs-master, ... }: {
  home.username = "fr13nd";
  home.homeDirectory = "/home/fr13nd";


  gtk = { inherit font; };

  home.packages = with pkgs; [
    telegram-desktop
    gnome-tweaks

    vesktop

    # other
    nerdfonts
  ];

  programs.home-manager.enable = true;

  # home.stateVersion = "23.05";
}
