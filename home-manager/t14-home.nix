{ pkgs, ... }:

{
  home.username = "rob";
  home.homeDirectory = "/home/rob";

  programs.waybar.hwmon-path = "/sys/devices/platform/thinkpad_hwmon/hwmon/hwmon4/temp1_input";
  programs.git.userEmail = "robert.rose@secunet.com";

  wayland.windowManager.sway.startupSync = [
    {
      command = "${pkgs.ungoogled-chromium}/bin/chromium";
      workspace = 4;
      appId = "chromium-browser";
    }
  ];
}
