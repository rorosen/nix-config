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
  ];

  programs.nixvim = {
    colorschemes.gruvbox.enable = true;
  };
}
