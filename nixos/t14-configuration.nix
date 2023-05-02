{ pkgs, ... }:

{
  imports = [
    ./configuration.nix
    ./t14-hardware-configuration.nix
  ];

  boot.initrd.systemd.enable = true;
  boot.initrd.luks.devices.cryptroot.crypttabExtraOpts = [ "fido2-device=auto" ];
  boot.initrd.luks.devices.cryptroot.device = "/dev/disk/by-uuid/cf687882-50a5-48e0-9bca-cb4677de63f1";

  system.flavour = "sway";

  networking.hostName = "t14";
  #boot.initrd.kernelModules = [ "amdgpu" ];
}