{ pkgs, ... }:
{
  imports = [
    ../../common
    ./kanshi.nix
  ];

  home.username = "rob";
  home.homeDirectory = "/home/rob";

  programs = {
    git.userEmail = "robert.rose@secunet.com";
    waybar = {
      hwmon-path-abs = [ "/sys/devices/platform/thinkpad_hwmon/hwmon" ];
      input-filename = "temp1_input";
    };
  };

  wayland.windowManager.sway.autostart = [
    {
      command = "${pkgs.ungoogled-chromium}/bin/chromium";
      workspace = 4;
      waitFor = "chromium-browser";
    }
  ];
}
