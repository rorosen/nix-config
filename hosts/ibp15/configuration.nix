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

  hardware.sane = {
    enable = true;
    extraBackends = [ pkgs.sane-airscan ];
  };

  networking = {
    hostName = "ibp15";
    hosts = {
      "192.168.50.155" = [
        "nextcloud.dev.internal"
        "auth.dev.internal"
        "dashboard.dev.internal"
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
    users.rob = import ../../rob/ibp15.nix;
    extraSpecialArgs = {
      inherit inputs;
    };
  };
}
