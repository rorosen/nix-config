{
  pkgs,
  config,
  lib,
  ...
}:
let
  cfg = config.wayland.windowManager.sway;
  autostartModule = lib.types.submodule {
    options = {
      command = lib.mkOption {
        type = lib.types.str;
        description = "Command to run.";
      };

      workspace = lib.mkOption {
        type = lib.types.number;
        description = "Workspace on which the command is run.";
      };

      waitFor = lib.mkOption {
        type = lib.types.str;
        default = "";
        description = "app_id (wayland) or instance string (xwayland) to wait for";
      };
    };
  };

  autostartEntryStr =
    {
      command,
      workspace,
      waitFor,
      ...
    }:
    "${pkgs.sway-toolwait}/bin/sway-toolwait --workspace ${builtins.toString workspace} --command ${command} "
    + (if waitFor == "" then "--nocheck" else "--waitfor ${waitFor}");

  autostartScript = pkgs.writeShellScript "sway-autostart" ''
    ${builtins.concatStringsSep "\n" (map autostartEntryStr cfg.autostart)}
  '';
in
{
  options.wayland.windowManager.sway.autostart = lib.mkOption {
    type = lib.types.listOf autostartModule;
    default = [ ];
    description = "Applications that should be launched synchronously on a specific workspace at startup.";
  };

  config = lib.mkIf (builtins.length cfg.autostart > 0) {
    wayland.windowManager.sway.extraConfig = ''
      exec ${autostartScript}
    '';
  };
}
