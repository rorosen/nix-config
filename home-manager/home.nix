{ config, pkgs, ... }:

{
  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
    };
  };

  home = {
    username = "rob";
    homeDirectory = "/home/rob";
    keyboard.layout = "de";

    sessionVariables = {
      RUST_SRC_PATH = "${pkgs.rust.packages.stable.rustPlatform.rustLibSrc}";
    };
  };

  programs.home-manager.enable = true;

  xsession = {
    enable = true;
    numlock.enable = true;
  };

  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.11";

  imports = [
    ./packages.nix
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
    ./user-extras.nix
  ];
}
