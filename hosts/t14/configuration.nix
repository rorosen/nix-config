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

  nix.settings = {
    substituters = [ "http://seven-cache01.syseleven.seven.secunet.com/" ];
    trusted-public-keys = [ "seven-1:M1znlh60ChXxeuOXaxFVLTrmeJS+UpYVfmI5fmX2Itc=" ];
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
      # "192.168.122.54" = [ "kadem.herder.syseleven.seven.secunet.com" ];
      # "195.192.158.108" = ["git.seven.secucloud.secunet.com"];
    };
    wg-quick.interfaces.wg0.configFile = "/home/rob/.wireguard/wg0.conf";
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
