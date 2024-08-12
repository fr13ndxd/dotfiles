{ pkgs, inputs, config, ...}:

{
  home.packages = with pkgs; with nodePackages_latest; [
    inputs.status-bar.defaultPackage.${system}

    pulseaudio
  ];
}
