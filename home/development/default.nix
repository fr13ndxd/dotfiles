{ pkgs, ags, inputs, ... }: {
  imports = [ ./lazygit.nix ];
  home.packages = with pkgs; [
    # debugger
    gdb
    ltrace

    # zig
    pkgs.zigpkgs.master

    zon2nix

    # Nixfmt
    nixfmt-classic

    # C
    clang-tools
    clang

    # langs
    nodejs
    go
    typescript
    meson
    ninja
    eslint
    gnumake
    cmake
  ];
}
