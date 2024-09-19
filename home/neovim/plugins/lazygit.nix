{
  programs.nixvim = {
    plugins.lazygit.enable = true;
    keymaps = [
      {
        mode = "n";
        key = "<leader>g";
        action = ":LazyGit<CR>";
        options.silent = true;
      }
    ];
  };
}
