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

  programs.steam.enable = true;
  networking.hostName = "tower";
  services.openssh.enable = true;

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

  nix.settings.trusted-users = [ "nixremote" ];
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.rob = import ../../home-manager/rob/tower.nix;
    extraSpecialArgs = {
      inherit inputs;
    };
  };
}
