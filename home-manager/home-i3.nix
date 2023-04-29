{ ... }:

{
  imports = [
    ./home.nix
    ./i3
    ./polybar
    ./rofi
  ];

  xsession = {
    enable = true;
    numlock.enable = true;
  };

  home.packages = [
    brightnessctl
  ];
}
