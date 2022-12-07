{ config, pkgs, lib, ... }:

{
  imports = [
    ./zsh.nix
    ./alacritty.nix
    ./i3/i3.nix
    ./polybar/polybar.nix
    ./vscode.nix
    ./rofi/rofi.nix
    ./gtk.nix
    ./qt.nix
    ./gnome-keyring.nix
    ./git.nix
    ./ssh-agent.nix
    ./nemo.nix
  ];

  xsession = {
    enable = true;
    numlock.enable = true;
  };

  home.keyboard.layout = "de";
}

