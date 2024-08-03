{ inputs, pkgs, ... }:
{
  imports = [
    inputs.self.homeManagerModules.temp-linker
    ../../common
    ./kanshi.nix
  ];

  home.username = "rob";
  home.homeDirectory = "/home/rob";

  programs.git.userEmail = "robert.rose@secunet.com";

  wayland.windowManager.sway.autostart = [
    {
      command = "${pkgs.ungoogled-chromium}/bin/chromium";
      workspace = 4;
      waitFor = "chromium-browser";
    }
  ];

  services.temp-linker = {
    enable = true;

    name = "thinkpad";
    label = "CPU";
  };
}
