{ pkgs, ... }:
{
  wayland.windowManager.sway.autostart = [
    {
      command = "${pkgs.alacritty}/bin/alacritty";
      workspace = 2;
      waitFor = "Alacritty";
    }
    {
      command = "${pkgs.alacritty}/bin/alacritty";
      workspace = 3;
      waitFor = "Alacritty";
    }
  ];
  programs.alacritty = {
    enable = true;

    settings = {
      window = {
        title = "Terminal";
        padding.y = 5;
        dimensions = {
          lines = 75;
          columns = 100;
        };
      };

      font = {
        normal.family = "MesloLGSDZ Nerd Font";
        size = 8.0;
      };

      shell.program = "${pkgs.zsh}/bin/zsh";

      colors = {
        primary = {
          background = "0x1c1d1f";
          foreground = "0xEBEBEB";
        };
        cursor = {
          text = "0xEBEBEB";
          cursor = "#b19102";
        };
        normal = {
          black = "0x0D0D0D";
          red = "0xFF301B";
          green = "0xA0E521";
          yellow = "0xFFC620";
          blue = "0x178AD1";
          magenta = "0x9f7df5";
          cyan = "0x21DEEF";
          white = "0xEBEBEB";
        };
        bright = {
          black = "0x6D7070";
          red = "0xFF4352";
          green = "0xB8E466";
          yellow = "0xFFD750";
          blue = "0x1BA6FA";
          magenta = "0xB978EA";
          cyan = "0x73FBF1";
          white = "0xFEFEF8";
        };
      };
    };
  };
}
