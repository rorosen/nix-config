{ ... }:

{
  imports = [ ./sysmenu.nix ];

  programs.wofi = {
    enable = true;
    style = builtins.readFile ./style.css;
  };
}
