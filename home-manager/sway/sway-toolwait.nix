{ pkgs, ... }:

let
  python-packages = ps: [ i3ipc ];
in
{
  home.packages = [ (pkgs.python3.withPackages python-packages) ];
  home.file.".config/sway/sway-toolwait" = {
    executable = true;

    text = builtins.readFile ./sway-toolwait.py;
  };
}
