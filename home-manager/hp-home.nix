{pkgs, ...}: {
  home.username = "rob";
  home.homeDirectory = "/home/rob";

  home.packages = with pkgs; [
    nextcloud-client
    thunderbird
    signal-desktop
    prusa-slicer
    freecad
    element-desktop
    android-tools
  ];

  wayland.windowManager.sway.startupSync = [
    {
      command = "${pkgs.thunderbird}/bin/thunderbird";
      workspace = 19;
      appId = "thunderbird";
    }
  ];

  programs.git.userEmail = "robert.rose@mailbox.org";

  programs.hwmon-linker = {
    enable = true;

    name = "k10temp";
    label = "Tctl";
  };
}
