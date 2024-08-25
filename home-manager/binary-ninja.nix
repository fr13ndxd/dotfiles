{ pkgs, ags, inputs, ...}:
{
  home.packages = with pkgs; with nodePackages_latest; [
    (pkgs.buildFHSUserEnv {
       name = "binaryninja";
       targetPkgs = pkgs: with pkgs; [
         inputs.binary-ninja
       ];
       runScript = "${inputs.binary-ninja.packages.${system}.default}/bin/binaryninja";
    })
  ];
  home.file.".local/share/applications/binaryninja.desktop".text = ''
    [Desktop Entry]
    Type=Application
    Name=Binary Ninja
    Comment=Reverse engineering platform
    Exec=binaryninja
    Icon=binaryninja
    Terminal=false
    Categories=Development;Utility;
    StartupNotify=true
    MimeType=application/x-binaryninja;application/x-executable;
  '';
}
