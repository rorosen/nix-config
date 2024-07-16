{ pkgs, ... }:
{
  imports = [
    ../common/complete.nix
    ../common/sway
    ../common/nextcloud-client.nix
  ];

  home.username = "rob";
  home.homeDirectory = "/home/rob";

  home.packages = with pkgs; [
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
  ];

  programs.git.userEmail = "robert.rose@mailbox.org";

  wayland.windowManager.sway.autostart = [
    {
      command = "${pkgs.thunderbird}/bin/thunderbird";
      workspace = 19;
      waitFor = "thunderbird";
    }
  ];

  services.temp-linker = {
    enable = true;

    name = "k10temp";
    label = "Tctl";
  };
}
