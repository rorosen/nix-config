{ lib, pkgs, ... }:
{
  programs.nixvim = {
    plugins.conform-nvim = {
      enable = true;
      settings = {
        notify_on_error = true;
        formatters_by_ft = {
          bash = [ "shfmt" ];
          json = [ "jq" ];
          markdown = [ "deno_fmt" ];
          nix = [ "nixfmt" ];
          sh = [ "shfmt" ];
          toml = [ "taplo" ];
          yaml = [ "yamlfmt" ];
        };
        formatters = {
          deno_fmt = {
            command = lib.getExe pkgs.deno;
            args.__raw = ''
              function(self, ctx)
                local extensions = {
                  javascript = "js",
                  javascriptreact = "jsx",
                  json = "json",
                  jsonc = "jsonc",
                  markdown = "md",
                  esmodule = "mjs",
                  typescript = "ts",
                  typescriptreact = "tsx",
                }
                return {
                  "fmt",
                  "-",
                  "--ext",
                  extensions[vim.bo[ctx.buf].filetype],
                  "--line-width",
                  "100",
                }
              end
            '';
          };
          jq.command = lib.getExe pkgs.jq;
          nixfmt.command = lib.getExe pkgs.nixfmt-rfc-style;
          shfmt.command = lib.getExe pkgs.shfmt;
          taplo.command = lib.getExe pkgs.taplo;
          yamlfmt.command = lib.getExe pkgs.yamlfmt;
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
