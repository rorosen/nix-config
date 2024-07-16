{ pkgs, ... }:
{
  imports = [
    ./sway
    ./waybar
    ./wofi
    ./swaylock.nix
    ./wlogout.nix
    ./swayidle.nix
    ./dunst.nix
  ];

  home.packages = with pkgs; [
    grim
    slurp
    wl-clipboard
  ];

  programs.bash = {
    enable = true;
    profileExtra = ''
      export SDL_VIDEODRIVER=wayland
      export _JAVA_AWT_WM_NONREPARENTING=1
      export QT_QPA_PLATFORM=wayland
      export XDG_CURRENT_DESKTOP=sway
      export XDG_SESSION_DESKTOP=sway
      [ "$(tty)" = "/dev/tty1" ] && exec ${pkgs.sway}/bin/sway
    '';
  };
}
