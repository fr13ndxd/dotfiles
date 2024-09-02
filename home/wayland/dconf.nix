{ lib, ... }:
with lib.hm.gvariant; {
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      cursor-theme = "catppuccin-mocha-dark-cursors";
    };
  };
}
