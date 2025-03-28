{ pkgs, ... }:
{
  imports = [ ../../home ];

  home = {
    username = "rob";
    homeDirectory = "/home/rob";
    packages = with pkgs; [
      thunderbird
      signal-desktop
      prusa-slicer
      freecad-wayland
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
    firefox.profiles.rob.bookmarks = {
      force = true;
      settings = [
        {
          name = "ibp15 sites";
          toolbar = true;
          bookmarks = [
            {
              name = "Nextcloud";
              url = "https://nextcloud.rorose.de";
            }
            {
              name = "Grafana";
              url = "https://dashboard.rorose.de";
            }
          ];
        }
      ];
    };
  };
  wayland.windowManager.sway.toolwait = [
    {
      command = "${pkgs.thunderbird}/bin/thunderbird";
      workspace = 19;
      waitFor = "thunderbird";
    }
  ];
  wayland.windowManager.sway.config.output."eDP-1".scale = "1.5";
  services.nextcloud-client = {
    enable = true;
    startInBackground = true;
  };
}
