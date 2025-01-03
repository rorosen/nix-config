{ pkgs, ... }:
{
  programs.nixvim = {
    plugins.lazygit.enable = true;
    keymaps = [
      {
        mode = "n";
        key = "<leader>g";
        action = ":LazyGit<CR>";
        options.silent = true;
      }
    ];
  };
  home.file.".config/lazygit/config.yml" = {
    source = (pkgs.formats.yaml { }).generate "lazygit-config.yml" {
      quitOnTopLevelReturn = true;
    };
  };
}
