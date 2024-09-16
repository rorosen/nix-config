{ pkgs, ... }:
{
  home.packages = with pkgs; [
    nixfmt-rfc-style
    prettierd
    yamlfmt
    shfmt
    taplo
  ];
  programs.nixvim = {
    plugins.conform-nvim = {
      enable = true;
      settings = {
        notify_on_error = true;
        format_on_save.lspFallback = true;
        formatters_by_ft = {
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
