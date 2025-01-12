{
  imports = [
    ./barbar.nix
    ./comments.nix
    ./conform.nix
    ./fidget.nix
    ./floaterm.nix
    ./gitblame.nix
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
    ./vimtex.nix
  ];

  programs.nixvim = {
    colorschemes.gruvbox.enable = true;
    plugins = {
      noice.enable = true;
      notify.enable = true;
      helm.enable = true;
      indent-blankline.enable = true;
      nvim-autopairs.enable = true;
      web-devicons.enable = true;
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
