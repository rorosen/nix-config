{
  programs.nixvim.plugins.lsp = {
    enable = true;

    keymaps = {
      silent = true;
      diagnostic = {
        # Navigate in diagnostics
        "<leader>k" = "goto_prev";
        "<leader>j" = "goto_next";
      };

      lspBuf = {
        gd = "definition";
        gD = "references";
        gt = "type_definition";
        gi = "implementation";
        K = "hover";
        "<F2>" = "rename";
      };
    };

    servers = {
      clangd.enable = true; # C/C++
      texlab.enable = true; # Tex
      nil-ls.enable = true; # Nix
      bashls.enable = true; # Bash
      marksman.enable = true; # Markdown
      yamlls.enable = true; # YAML
      jsonls.enable = true; # JSON
      gopls.enable = true; # Go

      # Rust
      rust-analyzer = {
        enable = true;
        installCargo = false;
        installRustc = false;
      };
    };
  };
}
