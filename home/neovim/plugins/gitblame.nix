{
  programs.nixvim = {
    plugins.gitblame = {
      enable = true;
      settings.enabled = false;
    };
    keymaps = [
      {
        mode = [
          "n"
          "v"
        ];
        key = "<leader>y";
        action = ":GitBlameToggle<cr>";
        options.silent = true;
      }
    ];
  };
}
