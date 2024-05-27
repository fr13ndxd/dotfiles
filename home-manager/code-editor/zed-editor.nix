{ pkgs, lib, ...}:
# let
#   ifLinux = lib.mkIf pkgs.stdenv.isLinux;
# in
{
  home.packages = with pkgs; [
    zed-editor
  ];
}
