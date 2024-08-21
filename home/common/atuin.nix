_: {
  programs.atuin = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      search_mode = "fulltext";
      update_check = false;
    };
    flags = [ "--disable-up-arrow" ];
  };
}
