{ pkgs, ... }: {
  home.packages = with pkgs; [
    vscode-langservers-extracted
    lldb
    clang

    # javascript, typescript
    typescript-language-server

    # c#
    omnisharp-roslyn
  ];
}
