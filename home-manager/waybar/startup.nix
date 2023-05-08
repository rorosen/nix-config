{ pkgs, config, ... }:

{
  home.file.".config/waybar/startup" = {
    executable = true;

    text = ''
      #!${pkgs.bash}/bin/bash

      ${pkgs.procps}/bin/pkill waybar
      ${if config.programs.waybar.hwmon.dynamic.enable then "${config.home.homeDirectory}/.config/waybar/hwmon-dynamic" else "" }
      ${pkgs.waybar}/bin/waybar &
    '';
  };
}
