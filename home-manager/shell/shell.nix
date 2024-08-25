{ pkgs, config, ... }:
let
  lang = icon: color: {
    symbol = icon;
    format = "[$symbol ](${color})";
  };
  email = "fr13nd65@protonmail.com";
  name = "fr13nd";
in {
  imports = [ ./starship.nix ./wezterm.nix ];

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
    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      shellAliases = {
        "ls" = "ls -A --color=auto";
        "mkcd" =
          ''function mkcd_func() { mkdir -p "$1" && cd "$1" }; mkcd_func'';
      };
      syntaxHighlighting.enable = true;
      initExtra = ''
        SHELL=${pkgs.zsh}/bin/zsh
        zstyle ':completion:*' menu select
        bindkey "^[[1;5C" forward-word
        bindkey "^[[1;5D" backward-word
        unsetopt BEEP
      '';
    };

    nushell = {
      enable = true;
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
      in ''
        $env.config = ${conf};
        ${completions [ "cargo" "git" "nix" "npm" "poetry" "curl" ]}

        alias pueue = ${pkgs.pueue}/bin/pueue
        alias pueued = ${pkgs.pueue}/bin/pueued
        use ${pkgs.nu_scripts}/share/nu_scripts/modules/background_task/task.nu
      '';
    };
  };
}
