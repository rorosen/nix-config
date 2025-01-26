{ inputs, pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../common.nix
  ];

  boot.initrd = {
    kernelModules = [ "amdgpu" ];
    systemd.enable = true;
    luks.devices.enc.crypttabExtraOpts = [ "fido2-device=auto" ];
  };

  hardware = {
    tuxedo-rs.enable = true;
    sane = {
      enable = true;
      extraBackends = [ pkgs.sane-airscan ];
    };
  };

  networking = {
    hostName = "ibp15";
    hosts = {
      "192.168.122.109" = [
        "nextcloud.dev.internal"
        "auth.dev.internal"
        "dashboard.dev.internal"
        "mail.dev.internal"
      ];
    };
  };

  users.users.rob.extraGroups = [
    "dialout"
    "scanner"
  ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.rob = import ../../rob/ibp15;
    extraSpecialArgs = {
      inherit inputs;
    };
  };
}
