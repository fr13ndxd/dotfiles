{ pkgs, config, inputs, ... }:
let
  lang = icon: color: {
    symbol = icon;
    format = "[$symbol ](${color})";
  };
  email = "fr13nd65@protonmail.com";
  name = "fr13nd";
in {
  imports = [ ./starship.nix ];

  programs = {
    git = {
      enable = true;
      extraConfig = {
        color.ui = true;
        core.editor = "helix";
        credential.helper = "store";
        github.user = name;
      };
      userEmail = email;
      userName = name;
    };

    nushell = {
      enable = true;
      package =
        inputs.nixpkgs-stable.legacyPackages."${pkgs.hostPlatform.system}".nushell;
      environmentVariables = { SHELL = ''"${pkgs.nushell}/bin/nu"''; };
      extraConfig = let
        conf = builtins.toJSON {
          show_banner = false;
          edit_mode = "vi";

          ls.clickable_links = true;
          rm.always_trash = true;

          table = {
            mode = "compact"; # compact thin rounded
            index_mode = "always"; # alway never auto
            header_on_separator = false;
          };

          cursor_shape = {
            vi_insert = "line";
            vi_normal = "block";
          };

          menus = [{
            name = "completion_menu";
            only_buffer_difference = false;
            marker = "? ";
            type = {
              layout = "columnar"; # list, description
              columns = 4;
              col_padding = 2;
            };
            style = {
              text = "magenta";
              selected_text = "blue_reverse";
              description_text = "yellow";
            };
          }];
        };
        completions = let
          completion = name: ''
            source ${pkgs.nu_scripts}/share/nu_scripts/custom-completions/${name}/${name}-completions.nu
          '';
        in names:
        builtins.foldl' (prev: str: ''
          ${prev}
          ${str}'') "" (map (name: completion name) names);
        # nu
      in ''
        $env.config = ${conf};
        ${completions [ "cargo" "git" "nix" "npm" "poetry" "curl" ]}

        # --env needed, else cd wont change directory
        def --env mkcd [path?] {
          if $path == null {
            print "usage: mkcd <path>"
          } else {
            mkdir $path
            cd $path
          }
        }

        alias pueue = ${pkgs.pueue}/bin/pueue
        alias pueued = ${pkgs.pueue}/bin/pueued
        use ${pkgs.nu_scripts}/share/nu_scripts/modules/background_task/task.nu
      '';
    };
  };
}
