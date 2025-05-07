{ inputs, pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../common.nix
  ];

  boot = {
    kernelPackages = pkgs.linuxKernel.packages.linux_6_14;
    initrd.kernelModules = [ "amdgpu" ];
  };
  nix.settings.trusted-users = [ "nixremote" ];
  programs.steam.enable = true;
  services.openssh.enable = true;
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
  hardware.bluetooth.input.General.ClassicBondedOnly = false;
  networking = {
    hostName = "tower";
    hosts."192.168.122.85" = [
      "nextcloud.dev.internal"
      "auth.dev.internal"
      "dashboard.dev.internal"
    ];
  };

  users.users.rob = {
    extraGroups = [ "scanner" ];
    openssh.authorizedKeys.keyFiles = [
      ../../rob/id_ed25519_hp.pub
      ../../rob/id_ed25519_ibp15.pub
    ];
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.rob = import ../../rob/tower.nix;
    extraSpecialArgs = {
      inherit inputs;
    };
  };
}
