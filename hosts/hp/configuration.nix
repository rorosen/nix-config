{pkgs, ...}: {
  imports = [
    ./hardware-configuration.nix
    ../common/graphical
    ../common/graphical/sway.nix
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
}
