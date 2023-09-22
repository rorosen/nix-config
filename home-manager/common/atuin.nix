_: {
  programs.atuin = {
    enable = true;
    enableZshIntegration = true;

    settings.search_mode = "fulltext";
    flags = ["--disable-up-arrow"];
  };
}
