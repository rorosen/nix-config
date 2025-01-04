{ pkgs, ... }:
{
  programs.nixvim = {
    plugins.lazygit =
      let
        configFile = (pkgs.formats.yaml { }).generate "lazygit-config.yml" {
          quitOnTopLevelReturn = true;
        };
      in
      {
        enable = true;
        settings = {
          use_custom_config_file_path = 1;
          config_file_path = "${configFile}";
        };
      };
    keymaps = [
      {
        mode = "n";
        key = "<leader>g";
        action = ":LazyGit<CR>";
        options.silent = true;
      }
    ];
  };
}
