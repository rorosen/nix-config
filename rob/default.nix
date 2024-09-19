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
    git.userEmail = "robert.rose@mailbox.org";
    waybar = {
      hwmon-path-abs = [ "/sys/devices/pci0000:00/0000:00:18.3/hwmon" ];
      input-filename = "temp1_input";
    };
  };
  wayland.windowManager.sway.autostart = [
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
