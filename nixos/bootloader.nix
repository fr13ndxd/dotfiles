{ pkgs, ... }:

{
 # users.users.fr13nd.packages = with pkgs; [
 #   catppuccin-grub
 # ];
  boot.loader = {
    efi.canTouchEfiVariables = true;
    grub = {
      enable = true;
      catppuccin = {
          enable = true;
          flavor = "mocha";
      };
      #extraConfig = "set theme=${pkgs.catppuccin-grub}/theme.txt";
      devices = [ "nodev" ];
      efiSupport = true;
      useOSProber = true;
    };
  };
}
