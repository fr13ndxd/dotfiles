{ pkgs, ags, inputs, ... }:
let
  binary-ninja-free =
    inputs.binary-ninja.packages.${pkgs.system}.binary-ninja-free-wayland;
in {
  home.packages = [ binary-ninja-free ];
  home.file.".local/share/applications/binaryninja.desktop".text = ''
    [Desktop Entry]
    Type=Application
    Name=Binary Ninja
    Comment=Reverse engineering platform
    Exec=${binary-ninja-free}/bin/binaryninja
    Icon=binaryninja
    Terminal=false
    Categories=Development;Utility;
    StartupNotify=true
    MimeType=application/x-binaryninja;application/x-executable;
  '';
}
