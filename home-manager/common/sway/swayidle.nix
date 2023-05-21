{pkgs, ...}: {
  services.swayidle = {
    enable = true;

    timeouts = [
      {
        timeout = 600;
        command = ''${pkgs.sway}/bin/swaymsg "output * dpms off"; ${pkgs.swaylock}/bin/swaylock --daemonize'';
        resumeCommand = ''${pkgs.sway}/bin/swaymsg "output * dpms on"'';
      }
    ];
  };
}
