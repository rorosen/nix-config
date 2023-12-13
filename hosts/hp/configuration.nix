{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ../common
    ../common/wayland.nix
  ];

  networking.hostName = "hp";
  networking.hosts = {
    "192.168.122.23" = [
      "nextcloud.dev.internal"
      "auth.dev.internal"
      "dashboard.dev.internal"
    ];
  };

  boot.initrd.kernelModules = ["amdgpu"];
  hardware.sane = {
    enable = true;
    extraBackends = [pkgs.sane-airscan];
  };

  users.users.rob = {
    isNormalUser = true;
    extraGroups = ["wheel" "libvirtd" "docker" "cups" "lp" "audio" "wireshark" "video" "input" "scanner"];
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.rob = import ../../home-manager/rob/hp.nix;
    extraSpecialArgs = {
      inherit inputs;
    };
  };
}
