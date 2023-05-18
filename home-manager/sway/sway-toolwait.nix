{pkgs, ...}: let
  swayPython = pkgs.python3.withPackages (ps: [ps.i3ipc]);
in {
  home.packages = [swayPython];
  home.file.".config/sway/sway-toolwait" = {
    executable = true;

    text = "#!${swayPython}/bin/python3 -B\n" + builtins.readFile ./sway-toolwait.py;
  };
}
