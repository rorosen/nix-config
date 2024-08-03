{ inputs, pkgs, ... }:
{
  imports = [
    inputs.self.homeManagerModules.temp-linker
    ../common
  ];

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

  programs.git.userEmail = "robert.rose@mailbox.org";
  wayland.windowManager.sway.autostart = [
    {
      command = "${pkgs.thunderbird}/bin/thunderbird";
      workspace = 19;
      waitFor = "thunderbird";
    }
  ];
  services = {
    nextcloud-client = {
      enable = true;
      startInBackground = true;
    };
    temp-linker = {
      enable = true;
      name = "k10temp";
      label = "Tctl";
    };
  };
}
