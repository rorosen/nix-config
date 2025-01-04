{
  lib,
  pkgs,
  config,
  ...
}:
{
  imports = [ ../home ];

  home = {
    username = "rob";
    homeDirectory = "/home/rob";
    packages = with pkgs; [
      thunderbird
      signal-desktop
      freecad
      android-tools
      joplin-desktop
      kicad
      pcb2gcode
      spotify
    ];
  };

  programs.waybar = {
    hwmon-path-abs = [ "/sys/devices/pci0000:00/0000:00:18.3/hwmon" ];
    input-filename = "temp1_input";
  };
  wayland.windowManager.sway.toolwait = lib.mkForce [
    {
      command = "${config.programs.steam.package}/bin/steam";
      workspace = 1;
      waitFor = "steam";
    }
  ];
  services.nextcloud-client = {
    enable = true;
    startInBackground = true;
  };
}
