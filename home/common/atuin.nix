_: {
  programs.atuin = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      keymap_mode = "vim-normal";
      search_mode = "fulltext";
      update_check = false;
    };
    flags = [ "--disable-up-arrow" ];
  };
}
