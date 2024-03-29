{ inputs, ... }: {
  imports = [
    ./hardware-configuration.nix
    ../common
    ../common/wayland.nix
  ];

  boot.initrd.systemd.enable = true;
  boot.initrd.luks.devices.cryptroot.crypttabExtraOpts = [ "fido2-device=auto" ];
  boot.initrd.luks.devices.cryptroot.device = "/dev/disk/by-uuid/cf687882-50a5-48e0-9bca-cb4677de63f1";

  networking.hostName = "t14";
  networking.hosts = {
    "192.168.122.69" = [
      "auth.kadem.internal"
      "dashboard.kadem.internal"
      "registry.kadem.internal"
    ];
    # "195.192.158.108" = ["git.seven.secucloud.secunet.com"];
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
    users.rob = import ../../home-manager/rob/t14;
    extraSpecialArgs = {
      inherit inputs;
    };
  };
}
