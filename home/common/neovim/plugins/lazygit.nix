{
  programs.nixvim = {
    plugins.lazygit.enable = true;
    keymaps = [
      {
        mode = "n";
        key = "gg";
        action = ":LazyGit<CR>";
        options.silent = true;
      }
    ];
  };
}
