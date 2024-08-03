{ inputs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../common.nix
  ];

  boot.initrd = {
    systemd.enable = true;
    luks.devices.cryptroot = {
      device = "/dev/disk/by-uuid/cf687882-50a5-48e0-9bca-cb4677de63f1";
      crypttabExtraOpts = [ "fido2-device=auto" ];
    };
  };

  networking = {
    hostName = "t14";
    hosts = {
      "192.168.101.69" = [
        "example.kadem.internal"
        "auth.kadem.internal"
        "dashboard.kadem.internal"
        "registry.kadem.internal"
      ];
      # "195.192.158.108" = ["git.seven.secucloud.secunet.com"];
    };
  };

  users.users.rob = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "libvirtd"
      "docker"
      "cups"
      "lp"
      "audio"
      "wireshark"
      "video"
      "input"
    ];
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.rob = import ../../home/rob/t14;
    extraSpecialArgs = {
      inherit inputs;
    };
  };
}
