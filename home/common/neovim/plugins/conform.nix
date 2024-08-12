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
    userCommands.Format = {
      range = true;
      command = ''
        function(args)
          local range = nil
          if args.count ~= -1 then
            local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
            range = {
              start = { args.line1, 0 },
              ["end"] = { args.line2, end_line:len() },
            }
          end
          require("conform").format({ async = true, lsp_format = "fallback", range = range })
        end
      '';
    };
  };
}
