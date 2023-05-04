{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    defaultEditor = true;

    extraPackages = with pkgs; [
      rust-analyzer
    ];

    plugins = with pkgs.vimPlugins; [
      nvim-lspconfig
    ];

    extraConfig = ''
      set number relativenumber
    '';

    extraLuaConfig = ''
      require'lspconfig'.rust_analyzer.setup{}
    '';
  };
}
