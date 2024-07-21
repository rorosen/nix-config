{ inputs, pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../common
    ../common/wayland.nix
  ];

  boot.initrd.kernelModules = [ "amdgpu" ];
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

  nix.settings.trusted-users = [ "nixremote" ];
  services.openssh.enable = true;
  programs.steam.enable = true;
  networking = {
    hostName = "tower";

    hosts = {
      "192.168.122.23" = [
        "nextcloud.dev.internal"
        "auth.dev.internal"
        "dashboard.dev.internal"
      ];
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
      "scanner"
    ];
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.rob = import ../../home-manager/rob;
    extraSpecialArgs = {
      inherit inputs;
    };
  };
}
