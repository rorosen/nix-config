{ pkgs, lib, config, ... }:

let
  inherit (lib) mkOption mkEnableOption mkIf types;
  cfg = config.programs.waybar.hwmon.dynamic;
in
{
  options.programs.waybar.hwmon.dynamic = {
    enable = mkEnableOption "enable dynamic linking of hwmon path.";
    name = mkOption {
      type = types.str;
      default = "";
      description = "The name of the hwmon path to use.";
    };
    label = mkOption {
      type = types.str;
      default = "";
      description = "The label of the hwmon path to use.";
    };
    link = mkOption {
      type = types.str;
      default = "/tmp/temperature";
      description = "The link to create for the specified hwmon path.";
    };
  };

  config = mkIf cfg.enable {
    home.file.".config/waybar/hwmon-dynamic" = {
      executable = true;

      text = ''
        #!${pkgs.bash}/bin/bash

        for i in /sys/class/hwmon/hwmon*/temp*_input; do
          if [[ "$(<$(dirname "$i")/name)" == "${cfg.name}" && "$(cat "''${i%_*}_label" 2>/dev/null || basename "''${i%_*}")" == "${cfg.label}" ]]; then
            ln -sf "$i" ${cfg.link}
          fi
        done
      '';
    };
  };
}
