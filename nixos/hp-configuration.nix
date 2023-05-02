{ pkgs, ... }:

{
  imports = [
    ./configuration.nix
    ./hp-hardware-configuration.nix
  ];

  system.flavour = "sway";
  networking.hostName = "hp";

  boot.initrd.kernelModules = [ "amdgpu" ];
  # Enable scanner support
  hardware.sane = {
    enable = true;
    extraBackends = [ pkgs.sane-airscan ];
  };

  users.users.rob = {
    isNormalUser = true;
    extraGroups = [ "wheel" "libvirtd" "docker" "cups" "lp" "audio" "wireshark" "video" "input" "scanner" ];
  };
}
