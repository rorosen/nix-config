{ pkgs, ... }:
{
  imports = [ ../home ];

  home = {
    username = "rob";
    homeDirectory = "/home/rob";
    packages = with pkgs; [
      thunderbird
      signal-desktop
      prusa-slicer
      freecad
      android-tools
      simple-scan
      joplin-desktop
      kicad
      pcb2gcode
      candle
      spotify
    ];
  };

  programs = {
    ssh = {
      enable = true;
      matchBlocks.tower.extraOptions = {
        RequestTTY = "yes";
        RemoteCommand = "zsh";
      };
    };
    waybar = {
      # find /sys/devices -name "temp*input"
      # /sys/devices/pci0000:00/0000:00:18.3/hwmon/hwmon4/temp1_input
      hwmon-path-abs = [ "/sys/devices/pci0000:00/0000:00:18.3/hwmon" ];
      input-filename = "temp1_input";
    };
  };
  wayland.windowManager.sway.toolwait = [
    {
      command = "${pkgs.thunderbird}/bin/thunderbird";
      workspace = 19;
      waitFor = "thunderbird";
    }
  ];
  services.nextcloud-client = {
    enable = true;
    startInBackground = true;
  };
}
