{ pkgs, ... }:

{
  programs.rofi = {
    enable = true;

    # plugins = [ pkgs.rofi-calc pkgs.rofi-emoji ];

    terminal = "${pkgs.alacritty}/bin/alacritty";
    theme = ./theme.rafi;
  };
}

