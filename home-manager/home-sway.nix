{ pkgs, ... }:

{
  imports = [
    ./home.nix
    ./sway.nix
    ./waybar
    ./wofi
    ./swaylock.nix
  ];

  programs.bash = {
    enable = true;
    profileExtra = ''
      [ "$(tty)" = "/dev/tty1" ] && exec ${pkgs.sway}/bin/sway
    '';
  };
}
