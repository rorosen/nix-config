{
  programs.nixvim = {
    plugins.lazygit.enable = true;
    keymaps = [
      {
        mode = "n";
        key = "<leader>,,";
        action = ":LazyGit<CR>";
        options.silent = true;
      }
    ];
  };
}
