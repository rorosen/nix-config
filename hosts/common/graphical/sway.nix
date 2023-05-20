{pkgs, ...}: {
  security.pam.services.swaylock = {};
  environment.systemPackages = with pkgs; [
    xdg-desktop-portal
    xdg-desktop-portal-wlr
    grim
  ];

  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = with pkgs; [xdg-desktop-portal-wlr];
  };

  programs.xwayland.enable = true;
}
