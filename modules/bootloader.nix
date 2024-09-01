{ pkgs, ... }:

{
  boot.loader = {
    efi.canTouchEfiVariables = true;
    grub = {
      enable = true;
      catppuccin = {
        enable = true;
        flavor = "mocha";
      };
      devices = [ "nodev" ];
      efiSupport = true;
      useOSProber = true;
    };
  };
}
