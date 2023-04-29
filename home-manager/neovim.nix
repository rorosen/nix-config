{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    coc.enable = true;

    viAlias = true;
    vimAlias = true;

    extraPackages = with pkgs; [
      rust-analyzer
    ];

    plugins = with pkgs.vimPlugins; [
      rust-vim
    ];

    extraConfig = ''
      set number relativenumber
    '';
  };
}
