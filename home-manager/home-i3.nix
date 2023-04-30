{ ... }:

{
  imports = [
    ./home-base.nix
    ./i3
    ./polybar
    ./rofi
    ./betterlockscreen.nix
  ];

  xsession = {
    enable = true;
    numlock.enable = true;
    profileExtra = ''
      export SSH_AUTH_SOCK=$XDG_RUNTIME_DIR/ssh-agent.socket;
    '';
  };

  home.packages = [
    brightnessctl
  ];
}
