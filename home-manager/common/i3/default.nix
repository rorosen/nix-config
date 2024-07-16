{ ... }:
{
  imports = [
    ./i3
    ./polybar
    ./rofi
    ./betterlockscreen.nix
  ];

  xsession = {
    enable = true;
    numlock.enable = true;
  };
}
