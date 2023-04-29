{ pkgs, ... }:

{
  imports = [
    ./home.nix
    ./sway.nix
    ./waybar
  ];

  programs.bash = {
    enable = true;
    profileExtra = ''
      [ "$(tty)" = "/dev/tty1" ] && exec ${pkgs.sway}/bin/sway
    '';
  };
}
