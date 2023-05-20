{pkgs, ...}: {
  imports = [./nextcloud-client.nix];

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

  wayland.windowManager.sway.startupSync = [
    {
      command = "${pkgs.thunderbird}/bin/thunderbird";
      workspace = 19;
      appId = "thunderbird";
    }
  ];

  services.temp-linker = {
    enable = true;

    name = "k10temp";
    label = "Tctl";
  };
}
