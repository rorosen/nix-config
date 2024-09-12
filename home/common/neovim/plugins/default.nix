{
  imports = [
    ./barbar.nix
    ./comments.nix
    ./conform.nix
    ./fidget.nix
    ./floaterm.nix
    ./lazygit.nix
    ./lsp.nix
    ./lualine.nix
    ./markdown-preview.nix
    ./neo-tree.nix
    ./oil.nix
    ./tagbar.nix
    ./telescope.nix
    ./todo.nix
    ./treesitter.nix
    ./trouble.nix
  ];

  programs.nixvim = {
    colorschemes.gruvbox.enable = true;
    plugins = {
      noice.enable = true;
      notify.enable = true;
      indent-blankline.enable = true;
      nvim-autopairs.enable = true;
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
