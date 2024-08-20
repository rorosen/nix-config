{
  imports = [
    ./lualine.nix
    ./neo-tree.nix
    ./markdown-preview.nix
    ./barbar.nix
    ./floaterm.nix
    ./alpha.nix
    ./tagbar.nix
    ./telescope.nix
    ./treesitter.nix
    ./lsp.nix
    # ./efm.nix
    ./todo.nix
    ./comments.nix
    ./conform.nix
    ./fidget.nix
    ./lazygit.nix
    ./trouble.nix
    ./oil.nix
  ];

  programs.nixvim = {
    colorschemes.gruvbox.enable = true;
    plugins = {
      noice.enable = true;
      notify.enable = true;
      indent-blankline.enable = true;
      nvim-autopairs.enable = true;
      # persistence.enable = true;
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
