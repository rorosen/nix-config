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
      settings = {
        notifyOnError = true;
        formatOnSave.lspFallback = true;
        formattersByFt = {
          nix = [ "nixfmt" ];
          markdown = [ "prettierd" ];
          json = [ "prettierd" ];
          yaml = [ "yamlfmt" ];
          css = [ "prettierd" ];
          html = [ "prettierd" ];
          sh = [ "shfmt" ];
          toml = [ "taplo" ];
        };
      };
    };
    keymaps = [
      {
        mode = [
          "n"
          "v"
        ];
        key = "<leader>ö";
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
