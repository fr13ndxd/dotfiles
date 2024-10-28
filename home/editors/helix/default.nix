{ pkgs, inputs, ... }: {
  programs.helix = {
    enable = true;
    package = inputs.helix-master.packages.${pkgs.system}.default;
    settings = {
      theme = "catppuccin_mocha";
      editor = {
        line-number = "relative";
        cursorline = true;
        scrolloff = 5;
        color-modes = true;
        idle-timeout = 1;
        true-color = true;
        rainbow-brackets = true;
        bufferline = "always";
        rulers = [ 100 ];
        popup-border = "all";
        soft-wrap.enable = true;
        completion-replace = true;
        cursor-shape = {
          normal = "block";
          insert = "bar";
          select = "underline";
        };

        sticky-context = {
          enable = true;
          indicator = false;
        };

        lsp = {
          display-messages = true;
          display-inlay-hints = false;
        };

        inline-diagnostics = {
          cursor-line = "hint";
          other-lines = "disable";
        };

        whitespace = {
          render.space = "all";
          whitespace.characters.space = "·";
        };

        gutters = [ "diagnostics" "line-numbers" "spacer" "diff" ];
        statusline = {
          separator = "of";
          left = [
            "mode"
            "selections"
            "file-type"
            "register"
            "spinner"
            "diagnostics"
          ];
          center = [ "file-name" ];
          right = [
            "file-encoding"
            "file-line-ending"
            "position-percentage"
            "spacer"
            "separator"
            "total-line-numbers"
          ];
          mode = {
            normal = "NORMAL";
            insert = "INSERT";
            select = "SELECT";
          };
        };

        indent-guides = {
          render = true;
          rainbow-option = "none";
        };
      };

      keys.insert = {
        "A-x" = "normal_mode";
        "C-x" = "completion";
      };

      keys.normal = {
        "y" = ":clipboard-yank";
        "p" = ":clipboard-paste-replace";
        "C-k" = "hover"; # show documentation for item under cursor (ctrl + k)
        "F1" = "command_palette";
        "C-f" = "file_picker";
        "X" = "extend_line_above";
        "C-s" = ":w";
        "C-q" = ":q";
        "C-d" = [ "half_page_down" "align_view_center" ];
        "C-u" = [ "half_page_up" "align_view_center" ];
      };

      keys.normal."\\" = { "t" = [ ":vs ~/todo.md" ]; };
    };
    languages = {
      language = [{
        name = "nix";
        auto-format = true;
        formatter.command = "${pkgs.nixfmt-classic}/bin/nixfmt";
      }];
    };
  };
}
