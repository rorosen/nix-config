{ config, pkgs, lib, ... }:

{
  imports = [
    ./i3
    ./polybar
    ./vscode
    ./rofi
    ./zsh
    ./alacritty.nix
    ./gtk.nix
    ./qt.nix
    ./gnome-keyring.nix
    ./git.nix
    ./ssh-agent.nix
    ./nemo.nix
    ./blueman.nix
  ];

  xsession = {
    enable = true;
    numlock.enable = true;
  };

  home.keyboard.layout = "de";
}

