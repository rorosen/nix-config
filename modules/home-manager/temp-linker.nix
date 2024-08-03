{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.services.temp-linker;
in
{
  options.services.temp-linker = {
    enable = lib.mkEnableOption "linking a hwmon temp input.";
    package = lib.mkPackageOption pkgs "temp-linker" { };

    name = lib.mkOption {
      type = lib.types.str;
      description = "The name of the hwmon temp input to use.";
    };

    label = lib.mkOption {
      type = lib.types.str;
      default = "";
      description = "The label of the hwmon temp input to use.";
    };

    link = lib.mkOption {
      type = lib.types.str;
      default = "/tmp/temperature";
      description = "The link to create for the specified hwmon temp input.";
    };

    systemd.target = lib.mkOption {
      type = lib.types.str;
      default = "graphical-session-pre.target";
      description = "The systemd target that wants this service.";
    };
  };

  config = lib.mkIf cfg.enable {
    systemd.user.services.temp-linker = {
      Unit.Description = "Tool that creates a symlink to a hwmon temp input";
      Install.WantedBy = [ cfg.systemd.target ];
      Service = {
        Type = "oneshot";
        ExecStart =
          "${cfg.package}/bin/temp-linker --name ${cfg.name} --link-path ${cfg.link}"
          + (lib.optionalString (cfg.label != "") " --label ${cfg.label}");
      };
    };
  };
}
