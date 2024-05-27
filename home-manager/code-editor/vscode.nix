{ pkgs, ...}:
{
  programs.vscode = {
    enable = true;
    package = pkgs.vscode.fhs;
    extensions = with pkgs.vscode-extensions; with pkgs.vscode-extensions.ms-dotnettools; [
      ms-dotnettools.csharp
    ];
  };
}