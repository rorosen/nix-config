{pkgs, ...}: {
  imports = [
    ../common/complete.nix
    ../common/sway
  ];

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
