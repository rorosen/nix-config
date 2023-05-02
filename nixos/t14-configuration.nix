{ pkgs, ... }:

{
  imports = [
    ./configuration.nix
    ./t14-hardware-configuration.nix
  ];

  system.flavour = "sway";

  networking.hostName = "t14";
  #boot.initrd.kernelModules = [ "amdgpu" ];
}
