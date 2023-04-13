{ config, pkgs, lib, ... }:

let
  hostName = "hp";
  videoDriver = "amdgpu";
in
{
  # Let the kernel load the video driver right away
  boot.initrd.kernelModules = [ videoDriver ];
  services.xserver.videoDrivers = [ videoDriver ];

  networking.hostName = hostName;
  # networking.extraHosts = "127.0.0.1 test.rorose.de";

  # Enable bluetooth
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  # Enable logitech udev rules
  hardware.logitech.wireless =  {
    enable = true;
    enableGraphical = true;
  };
}

