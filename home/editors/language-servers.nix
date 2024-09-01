{ pkgs, ... }: {
  home.packages = with pkgs; [
    vscode-langservers-extracted
    lldb
    clang
    rocmPackages.llvm.clang-tools-extra

    # javascript, typescript
    typescript-language-server
  ];
}
