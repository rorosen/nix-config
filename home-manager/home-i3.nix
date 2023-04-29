{ ... }:

{
  imports = [
    ./i3
    ./polybar
    ./rofi
    ./home.nix
  ];

  xsession = {
    enable = true;
    numlock.enable = true;
  };

  home.packages = [
    brightnessctl
  ];
}
