{ pkgs, ... }:

{
  imports = [ ./t14-kanshi.nix ];

  home.username = "rob";
  home.homeDirectory = "/home/rob";

  programs.git.userEmail = "robert.rose@secunet.com";
  programs.waybar.hwmon.dynamic = {
    enable = true;
    name = "thinkpad";
    label = "CPU";
  };

  wayland.windowManager.sway.startupSync = [
    {
      command = "${pkgs.ungoogled-chromium}/bin/chromium";
      workspace = 4;
      appId = "chromium-browser";
    }
  ];
}
