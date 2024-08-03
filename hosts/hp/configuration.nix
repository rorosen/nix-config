{ inputs, pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../common.nix
  ];

  boot.initrd.kernelModules = [ "amdgpu" ];
  hardware.sane = {
    enable = true;
    extraBackends = [ pkgs.sane-airscan ];
  };

  networking = {
    hostName = "hp";
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

  nix = {
    buildMachines = [
      {
        hostName = "tower";
        system = "x86_64-linux";
        protocol = "ssh-ng";
        maxJobs = 1;
      }
    ];
    extraOptions = ''
      builders-use-substitutes = true
    '';
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.rob = import ../../home/rob;
    extraSpecialArgs = {
      inherit inputs;
    };
  };
}
