{ pkgs, inputs, ... }:

{
  home.packages = with pkgs;
    [
      # inputs.status-bar.defaultPackage.${system}
      pulseaudio
    ];
}
