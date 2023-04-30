{ pkgs, ... }:

{
  imports = [
    ./configuration-sway.nix
    ./hp-hardware-configuration.nix
  ];

  networking.hostName = "hp";
  boot.initrd.kernelModules = [ "amdgpu" ];

  # Enable scanner support
  hardware.sane = {
    enable = true;
    extraBackends = [ pkgs.sane-airscan ];
  };

  users.users.rob.extraGroups = [ "scanner" ];
}
