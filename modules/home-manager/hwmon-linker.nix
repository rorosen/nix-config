{
  inputs,
  pkgs,
  lib,
  config,
  ...
}: let
  inherit (lib) mkOption mkEnableOption mkIf types;
  cfg = config.programs.hwmon-linker;
in {
  options.programs.hwmon-linker = {
    enable = mkEnableOption "enable creating a link of a hwmon path.";

    package = mkOption {
      type = types.package;
      default = inputs.hwmon-linker.packages.${pkgs.system}.default;
      description = "Package to use";
    };

    name = mkOption {
      type = types.str;
      description = "The name of the hwmon path to use.";
    };

    label = mkOption {
      type = types.str;
      description = "The label of the hwmon path to use.";
    };

    link = mkOption {
      type = types.str;
      default = "/tmp/temperature";
      description = "The link to create for the specified hwmon path.";
    };

    before = mkOption {
      type = types.str;
      default = "waybar.service";
      description = "The linking will happen before the specified unit is started.";
    };
  };

  config = mkIf cfg.enable {
    home.packages = [cfg.package];

    systemd.user.services.hwmon-linker = {
      Unit = {
        Description = "Tool that creates a symlink to a hwmon path";
        Before = [cfg.before];
      };

      Service = {
        Type = "oneshot";
        ExecStart = "${cfg.package}/bin/hwmon-linker --name ${cfg.name} --label ${cfg.label} --link-path ${cfg.link}";
      };

      Install = {WantedBy = ["multi-user.target"];};
    };
  };
}
