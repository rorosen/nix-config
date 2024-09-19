{ inputs, pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../common.nix
  ];

  nix.settings.trusted-users = [ "nixremote" ];
  services.openssh.enable = true;
  programs.steam.enable = true;
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
    users.rob = import ../../rob;
    extraSpecialArgs = {
      inherit inputs;
    };
  };
}
