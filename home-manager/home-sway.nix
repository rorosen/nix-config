{ ... }:

{
  imports = [
    ./home.nix
    ./sway.nix
    ./waybar.nix
  ];

  programs.zsh.initExtra = ''
    [ "$(tty)" = "/dev/tty1" ] && exec sway
  '';
}
