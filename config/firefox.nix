{
  programs.firefox = {
    enable = true;

    profiles."default" = {
      search = {
        default = "DuckDuckGo";
        force = true;
      };
    };
  };
}
