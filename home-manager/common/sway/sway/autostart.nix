{
  inputs,
  pkgs,
  config,
  lib,
  ...
}: let
  inherit (lib) mkOption types mkIf;
  cfg = config.wayland.windowManager.sway;

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

  autostartEntryStr = {
    command,
    workspace,
    waitFor,
    ...
  }:
    "${inputs.sway-toolwait.packages.${pkgs.system}.default}/bin/sway-toolwait --workspace ${builtins.toString workspace} --command ${command} "
    + (
      if waitFor == ""
      then "--nocheck"
      else "--waitfor ${waitFor}"
    );
in {
  options.wayland.windowManager.sway.autostart = mkOption {
    type = types.listOf autostartModule;
    default = [];
    description = "Applications that should be launched synchronously on a specific workspace at startup.";
  };

  config = mkIf (builtins.length cfg.autostart > 0) {
    home.packages = [inputs.sway-toolwait.packages.${pkgs.system}.default];

    home.file.".config/sway/autostart" = {
      executable = true;

      text = ''
        #!${pkgs.bash}/bin/bash

        ${builtins.concatStringsSep "\n" (map autostartEntryStr cfg.autostart)}
      '';
    };

    wayland.windowManager.sway.extraConfig = ''
      exec ${config.home.homeDirectory}/.config/sway/autostart
    '';
  };
}
