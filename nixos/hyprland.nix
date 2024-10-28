{ inputs, pkgs, ... }: {
  programs.hyprland = {
    enable = true;
    # portalPackage =
    # inputs.hyprland.packages.${pkgs.system}.xdg-desktop-portal-hyprland;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    xwayland.enable = true;
  };

  environment.systemPackages = with pkgs; [ wl-clipboard ];

  # xdg.portal = {
  #   enable = true;
  #   extraPortals = with pkgs;
  #     [
  #       # xdg-desktop-portal-gtk
  #     ];
  # };
}
