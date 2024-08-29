{ pkgs, ... }: {
  imports = [ ./fastfetch.nix ];
  home.packages = with pkgs; [ ani-cli ncdu tmate unzip ];
}
