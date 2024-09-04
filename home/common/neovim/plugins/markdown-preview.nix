{
  programs.nixvim = {
    plugins.markdown-preview = {
      enable = true;

      settings = {
        auto_close = false;
        page_title = "\$\{name}";
        theme = "dark";
      };
    };

    files."after/ftplugin/markdown.lua".keymaps = [
      {
        mode = "n";
        key = "<leader>m";
        action = ":MarkdownPreview<cr>";
      }
    ];
  };
}
