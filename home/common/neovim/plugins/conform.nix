{ pkgs, ... }:
{
  home.packages = with pkgs; [
    nixfmt-rfc-style
    prettierd
    yamlfmt
    shfmt
  ];
  programs.nixvim = {
    plugins.conform-nvim = {
      enable = true;
      formatOnSave.lspFallback = true;
      notifyOnError = true;
      formattersByFt = {
        nix = [ "nixfmt" ];
        markdown = [ "prettierd" ];
        json = [ "prettierd" ];
        yaml = [ "yamlfmt" ];
        css = [ "prettierd" ];
        html = [ "prettierd" ];
        sh = [ "shfmt" ];
      };
    };
    keymaps = [
      {
        mode = [
          "n"
          "v"
        ];
        key = "<leader>l";
        action.__raw = ''
          function()
            require("conform").format({ async = true, lsp_format = "fallback" })
          end
        '';
        options.silent = true;
      }
    ];
  };
}
