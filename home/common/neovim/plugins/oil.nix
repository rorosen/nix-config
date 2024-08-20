{
  programs.nixvim = {
    plugins.oil = {
      enable = true;
      settings.view_options.show_hidden = true;
    };

    keymaps = [
      {
        mode = "n";
        key = "<leader>n";
        action = ":Oil<CR>";
        options.silent = true;
      }
    ];
  };
}
