{ pkgs, ... }:
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
  services.nextcloud-client = {
    enable = true;
    startInBackground = true;
  };
  wayland.windowManager.sway.config.output."HDMI-A-1".mode = "1920x1080@60.000Hz";
}
