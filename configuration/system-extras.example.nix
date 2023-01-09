{ config, pkgs, lib, ... }:

let
  hostName = "hostName";
  videoDriver = "videoDriver";
in
{
  # Let the kernel load the video driver right away
  boot.initrd.kernelModules = [ videoDriver ];
  services.xserver.videoDrivers = [ videoDriver ];

  networking.hostName = hostName;

  # Enable bluetooth
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  # Enable logitech udev rules
  hardware.logitech.wireless =  {
    enable = true;
    enableGraphical = true;
  };
}

