{
  imports = [
    ./lualine.nix
    ./neo-tree.nix
    ./markdown-preview.nix
    ./barbar.nix
    ./floaterm.nix
    ./startify.nix
    ./tagbar.nix
    ./telescope.nix
    ./treesitter.nix
    ./lsp.nix
    ./efm.nix
    ./todo.nix
    ./completion.nix
  ];

  programs.nixvim = {
    colorschemes.gruvbox.enable = true;
    plugins = {
      nvim-autopairs.enable = true;
      nvim-colorizer = {
        enable = true;
        userDefaultOptions.names = false;
      };

      gitsigns = {
        enable = true;
        settings.signs = {
          add.text = "+";
          change.text = "~";
        };
      };

      trim = {
        enable = true;
        settings = {
          highlight = true;
          ft_blocklist = [
            "checkhealth"
            "floaterm"
            "lspinfo"
            "neo-tree"
            "TelescopePrompt"
          ];
        };
      };
    };
  };
}
