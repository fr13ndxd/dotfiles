{ pkgs, ... }: {
  imports = [ ./nvim ./helix ./vscode ./language-servers.nix ];
  xdg.configFile."zls.json".text = builtins.toJSON {
    "$schema" =
      "https://raw.githubusercontent.com/zigtools/zls/master/schema.json";
    enable_ast_check_diagnostics = true;
    enable_autofix = true;
    enable_import_embedfile_argument_completions = true;
    enable_inlay_hints = true;
    inlay_hints_hide_redundant_param_names = true;
    inlay_hints_hide_redundant_param_names_last_token = true;
    enable_semantic_tokens = true;
    max_detail_length = 104857;
    operator_completions = true;
    use_comptime_interpreter = true;
    warn_style = true;
    include_at_in_builtins = true;
    zig_exe_path = "${pkgs.zigpkgs.master.outPath}/bin/zig";
  };
}
