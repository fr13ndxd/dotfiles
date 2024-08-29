{ pkgs, ags, inputs, ... }: {
  home.packages = with pkgs;
    with nodePackages_latest; [
      # debugger
      gdb

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
