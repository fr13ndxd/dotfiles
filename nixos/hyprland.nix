{ inputs,
  pkgs,
  config,
  asztal,
  lib,
  ...
}: {
  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    xwayland.enable = true;
  };

  environment.systemPackages = with pkgs; [
    wl-clipboard
  ];

  services.greetd = {
    enable = true;
    settings.default_session.command = pkgs.writeShellScript "greeter" ''
      export XKB_DEFAULT_LAYOUT=${config.services.xserver.xkb.layout}
      export XCURSOR_THEME=Catppuccin-Mocha-Dark
      ${asztal}/bin/greeter
    '';
  };

  systemd.tmpfiles.rules = [
    "d '/var/cache/greeter' - greeter greeter - -"
  ];

  system.activationScripts.wallpaper = let
      wp = pkgs.writeShellScript "wp" ''
        CACHE="/var/cache/greeter"
        OPTS="$CACHE/options.json"
        HOME="/home/$(find /home -maxdepth 1 -printf '%f\n' | tail -n 1)"

        mkdir -p "$CACHE"
        chown greeter:greeter $CACHE

        if [[ -f "$HOME/.cache/ags/options.json" ]]; then
          cp $HOME/.cache/ags/options.json $OPTS
          chown greeter:greeter $OPTS
        fi

        if [[ -f "$HOME/.config/background" ]]; then
          cp "$HOME/.config/background" $CACHE/background
          chown greeter:greeter "$CACHE/background"
        fi
      '';
    in
      builtins.readFile wp;
}
