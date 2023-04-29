{ pkgs, ... }:

{
  imports = [
    ./home.nix
    ./sway.nix
    ./waybar
    ./wofi
  ];

  programs.bash = {
    enable = true;
    profileExtra = ''
      [ "$(tty)" = "/dev/tty1" ] && exec ${pkgs.sway}/bin/sway
    '';
  };
}
