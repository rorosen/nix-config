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

  networking.hostName = "tower";
  services.openssh.enable = true;
  boot.initrd.kernelModules = ["amdgpu"];

  hardware = {
    logitech.wireless = {
      enable = true;
      enableGraphical = true;
    };

    sane = {
      enable = true;
      extraBackends = [pkgs.sane-airscan];
    };
  };

  users.users.rob = {
    isNormalUser = true;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIE8BYhhtM7cj2GqBtW3ftPGtlBazkpePGrMSQX4MG2QD rob@hp"
    ];
    extraGroups = ["wheel" "libvirtd" "docker" "cups" "lp" "audio" "wireshark" "video" "input" "scanner"];
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.rob = import ../../home-manager/rob/tower.nix;
    extraSpecialArgs = {
      inherit inputs;
    };
  };
}
