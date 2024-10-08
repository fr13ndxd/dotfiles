{ pkgs, ags, inputs, ... }: {
  imports = [ ./lazygit.nix ];
  home.packages = with pkgs; [
    # debugger
    gdb
    ltrace

    # zig
    pkgs.zigpkgs.master

    # Nixfmt
    nixfmt-classic

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
