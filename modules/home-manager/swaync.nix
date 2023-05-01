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
      type = types.str;
    };

    style = mkOption {
      type = types.str;
    };
  };

  config = mkIf cfg.enable {
    home.file.".config/swaync/config.json".text = cfg.settings;

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
          "${cfg.package}/bin/swaync ";
      };

      Install = { WantedBy = [ cfg.systemd.target ]; };
    };
  };
}
