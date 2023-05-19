{
  inputs,
  pkgs,
  lib,
  config,
  ...
}: let
  inherit (lib) mkOption mkEnableOption mkIf types;
  cfg = config.services.temp-linker;
in {
  options.services.temp-linker = {
    enable = mkEnableOption "enable creating a link of a hwmon temp input.";

    package = mkOption {
      type = types.package;
      default = inputs.temp-linker.packages.${pkgs.system}.default;
      description = "Package to use";
    };

    name = mkOption {
      type = types.str;
      description = "The name of the hwmon temp input to use.";
    };

    label = mkOption {
      type = types.str;
      description = "The label of the hwmon temp input to use.";
    };

    link = mkOption {
      type = types.str;
      default = "/tmp/temperature";
      description = "The link to create for the specified hwmon temp input.";
    };

    systemd.target = mkOption {
      type = types.str;
      default = "graphical-session-pre.target";
      description = "The systemd target that wants this servce.";
    };
  };

  config = mkIf cfg.enable {
    home.packages = [cfg.package];

    systemd.user.services.temp-linker = {
      Unit = {
        Description = "Tool that creates a symlink to a hwmon temp input";
      };

      Service = {
        Type = "oneshot";
        ExecStart = "${cfg.package}/bin/temp-linker --name ${cfg.name} --label ${cfg.label} --link-path ${cfg.link}";
      };

      Install = {WantedBy = [cfg.systemd.target];};
    };
  };
}
