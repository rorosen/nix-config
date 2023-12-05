{pkgs, ...}: {
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    lxqt.enable = true;

    config.common.default = "*";
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
    ];
  };

  security.pam.services.swaylock = {};
  programs.xwayland.enable = true;
}
