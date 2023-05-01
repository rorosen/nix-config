# TODO: Does not work, fails each start with "COULD NOT FIND CSS FILE! REINSTALL THE PACKAGE!"

{ pkgs, lib, config, ... }:

let
  inherit (lib) mkEnableOption mkPackageOption mkOption mkIf types;
  cfg = config.services.swaync;
in
{
  options.services.swaync = {
    enable = mkEnableOption "a simple GTK based notification daemon for SwayWM";

    package = mkPackageOption pkgs "swaynotificationcenter" { };

    systemd.target = mkOption {
      type = types.str;
      default = "sway-session.target";
      description = "Systemd target to bind to.";
    };

    settings = mkOption {
      type = types.attrs;
    };

    style = mkOption {
      type = types.str;
    };
  };

  config = mkIf cfg.enable {
    home.file.".config/swaync/config.json".text = builtins.toJSON cfg.settings;

    home.file.".config/swaync/style.css".text = cfg.style;

    systemd.user.services.swaync = {
      Unit = {
        Description = "Simple GTK based notification daemon for SwayWM";
        Documentation = "man:swaync(1)";
        PartOf = [ "graphical-session.target" ];
      };

      Service = {
        Type = "simple";
        ExecStart =
          "${cfg.package}/bin/swaync --config ${config.home.homeDirectory}/.config/swaync/config.json --style ${config.home.homeDirectory}/.config/swaync/style.css";
      };

      Install = { WantedBy = [ cfg.systemd.target ]; };
    };
  };
}
