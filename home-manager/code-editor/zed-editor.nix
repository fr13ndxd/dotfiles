{ pkgs, lib, ...}:
{
  home.packages = with pkgs; [
    zed-editor
  ];
}
