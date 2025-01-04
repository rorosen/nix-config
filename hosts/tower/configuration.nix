{ inputs, pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../common.nix
  ];

  nix.settings.trusted-users = [ "nixremote" ];
  programs.steam.enable = true;
  boot.initrd.kernelModules = [ "amdgpu" ];

  services = {
    getty.autologinUser = "rob";
    openssh.enable = true;
  };

  hardware = {
    logitech.wireless = {
      enable = true;
      enableGraphical = true;
    };

    sane = {
      enable = true;
      extraBackends = [ pkgs.sane-airscan ];
    };
  };

  networking = {
    hostName = "tower";
    hosts = {
      "192.168.122.85" = [
        "nextcloud.dev.internal"
        "auth.dev.internal"
        "dashboard.dev.internal"
      ];
    };
  };

  users.users.rob.extraGroups = [ "scanner" ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.rob = import ../../rob/tower.nix;
    extraSpecialArgs = {
      inherit inputs;
    };
  };
}
