{
  programs.nixvim = {
    plugins = {
      lsp = {
        enable = true;

        keymaps = {
          silent = true;
          diagnostic = {
            # Navigate in diagnostics
            "<C-k>" = "goto_prev";
            "<C-j>" = "goto_next";
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
          nil_ls.enable = true; # Nix
          bashls.enable = true; # Bash
          marksman.enable = true; # Markdown
          yamlls.enable = true; # YAML
          jsonls.enable = true; # JSON
          gopls.enable = true; # Go
          helm_ls.enable = true; # Helm
        };
      };

      rustaceanvim = {
        enable = true;

        settings.server = {
          default_settings.rust-analyzer = {
            cargo.features = "all";
            checkOnSave = true;
            check.command = "clippy";
            rustc.source = "discover";
          };
        };
      };
    };
    keymaps = [
      {
        mode = "n";
        key = "<leader>a";
        action = "<cmd>RustLsp codeAction<cr>";
        options = {
          desc = "Rust hover actions";
          silent = true;
        };
      }
    ];
  };
}
