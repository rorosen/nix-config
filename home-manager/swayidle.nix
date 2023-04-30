{ ... }:

{
  services.swayidle = {
    enable = true;

    timeouts = [
      { timeout = 600; command = "${pkgs.swaylock}/bin/swaylock"; }
    ];
  };
}
