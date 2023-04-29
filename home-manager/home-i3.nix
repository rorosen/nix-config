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
    profileExtra = ''
      export SSH_AUTH_SOCK=$XDG_RUNTIME_DIR/ssh-agent.socket;
    '';
  };

  home.packages = [
    brightnessctl
  ];
}
