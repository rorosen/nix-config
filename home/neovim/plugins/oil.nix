{
  programs.nixvim = {
    plugins.oil = {
      enable = true;
      settings = {
        view_options.show_hidden = true;
        default_file_explorer = false;
      };
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
