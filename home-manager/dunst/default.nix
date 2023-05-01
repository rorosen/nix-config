{ pkgs, ... }:

{
  services.dunst = {
    enable = true;
    settings = builtins.readFile ./dunstrc;
  };
}
