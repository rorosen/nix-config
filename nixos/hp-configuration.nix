{ pkgs, ... }:

{
  imports = [
    ./configuration.nix
    ./hp-hardware-configuration.nix
  ];

  networking.hostName = "hp";
  boot.initrd.kernelModules = [ "amdgpu" ];

  programs = {
    light.enable = true;
    sway.enable = true;
  };
  xdg.portal.wlr.enable = true;

  # Enable scanner support
  hardware.sane = {
    enable = true;
    extraBackends = [ pkgs.sane-airscan ];
  };

  users.users.rob.extraGroups = [ "scanner" ];
}
