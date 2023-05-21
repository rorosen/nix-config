{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ../common/graphical
    ../common/graphical/wayland.nix
  ];

  networking.hostName = "hp";

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
