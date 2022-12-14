{ config, pkgs, lib, ... }:

{
  imports = [
    ./i3/i3.nix
    ./polybar/polybar.nix
    ./vscode/vscode.nix
    ./rofi/rofi.nix
    ./zsh.nix
    ./alacritty.nix
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

