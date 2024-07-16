{
  inputs,
  pkgs,
  config,
  lib,
  ...
}:
let
  inherit (lib) mkOption types mkIf;
  cfg = config.wayland.windowManager.sway;
  sway-toolwait = inputs.sway-toolwait.packages.${pkgs.system}.default;

  autostartModule = types.submodule {
    options = {
      command = mkOption {
        type = types.str;
        description = "Command to run.";
      };

      workspace = mkOption {
        type = types.number;
        description = "Workspace on which the command is run.";
      };

      waitFor = mkOption {
        type = types.str;
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
    "${sway-toolwait}/bin/sway-toolwait --workspace ${builtins.toString workspace} --command ${command} "
    + (if waitFor == "" then "--nocheck" else "--waitfor ${waitFor}");

  autostartScript = pkgs.writeShellScript "sway-autostart" ''
    ${builtins.concatStringsSep "\n" (map autostartEntryStr cfg.autostart)}
  '';
in
{
  options.wayland.windowManager.sway.autostart = mkOption {
    type = types.listOf autostartModule;
    default = [ ];
    description = "Applications that should be launched synchronously on a specific workspace at startup.";
  };

  config = mkIf (builtins.length cfg.autostart > 0) {
    home.packages = [ sway-toolwait ];

    wayland.windowManager.sway.extraConfig = ''
      exec ${autostartScript}
    '';
  };
}
