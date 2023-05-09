{ ... }:

{
  imports = [
    ./configuration.nix
    ./t14-hardware-configuration.nix
  ];

  system.flavor = "sway";
  networking.hostName = "t14";

  boot.initrd.systemd.enable = true;
  boot.initrd.luks.devices.cryptroot.crypttabExtraOpts = [ "fido2-device=auto" ];
  boot.initrd.luks.devices.cryptroot.device = "/dev/disk/by-uuid/cf687882-50a5-48e0-9bca-cb4677de63f1";

  users.users.rob = {
    isNormalUser = true;
    extraGroups = [ "wheel" "libvirtd" "docker" "cups" "lp" "audio" "wireshark" "video" "input" ];
  };
}
