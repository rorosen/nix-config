{ pkgs, ... }:

{
  imports = [ ./configuration-base.nix ];

  environment.systemPackages = with pkgs; [
    xdg-desktop-portal
    xdg-desktop-portal-wlr
    grim
  ];

  xdg.portal = {
    enable = true;
    wlr.enable = true;
  };

  programs = {
    light.enable = true;
    sway.enable = true;
  };

}
