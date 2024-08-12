{ pkgs, ... }:
let
  deps = with pkgs;
  with nodePackages_latest; [
    # js, html
    vscode-langservers-extracted
    tailwindcss-language-server
    typescript-language-server
    svelte-language-server
    eslint deno
    typescript

    # markup
    marksman
    markdownlint-cli
    taplo # toml
    yaml-language-server

    # python
    ruff
    ruff-lsp
    pyright

    # bash
    shfmt
    bash-language-server

    nushell
  ];
in
{
  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;

    withRuby = true;
    withNodeJs = true;

    extraPackages = with pkgs; [
        git
        nil
        lua-language-server
        gcc
        gnumake
        unzip
        wget
        curl
        tree-sitter
        ripgrep
        fd
        fzf
      ]
      ++ deps;
  };

  xdg.configFile.nvim.source = ../../nvim;
}
