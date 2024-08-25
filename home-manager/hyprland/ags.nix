{ inputs, pkgs, ... }: {
  imports = [ inputs.ags.homeManagerModules.default ];

  home.packages = with pkgs; [
    # asztal
    bun
    dart-sass
    fd
    brightnessctl
    swww
    slurp
    wf-recorder
    wl-clipboard
    wayshot
    swappy
    hyprpicker
    pavucontrol
    networkmanager
    gtk3
    hyprshot
  ];

  programs.ags = {
    enable = true;
    configDir = ../../ags;
    extraPackages = [ pkgs.libsoup_3 pkgs.accountsservice ];
  };
}
