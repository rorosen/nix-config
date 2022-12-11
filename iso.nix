{ config, pkgs, ... }:

{
  imports = [
    <nixpkgs/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix>

    # Provide an initial copy of the NixOS channel so that the user
    # doesn't need to run "nix-channel --update" first.
    <nixpkgs/nixos/modules/installer/cd-dvd/channel.nix>
  ];

  isoImage.squashfsCompression = "lz4";

  time.timeZone = "Europe/Berlin";
  console.keyMap = "de-latin1";

  environment.systemPackages = with pkgs; [
    vim
  ];

  environment.etc.configuration.source = ./configuration;
}

