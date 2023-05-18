{pkgs, ...}: {
  imports = [
    ./configuration.nix
    ./hp-hardware-configuration.nix
  ];

  system.flavor = "sway";
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
