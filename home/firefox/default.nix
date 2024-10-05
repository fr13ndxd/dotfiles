pkgs: {
  programs.firefox = {
    enable = true;
    profiles."default" = {
      id = 0;
      isDefault = true;
      userChrome = pkgs.lib.strings.concatStringsSep "\n" [''
        #tabbrowser-tabbox {
          border-radius: 8px;
          position: relative;
          overflow: hidden;
        }
      ''];
    };

  };
}
