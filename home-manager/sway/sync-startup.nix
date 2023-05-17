{
  pkgs,
  config,
  lib,
  ...
}: let
  cfg = config.wayland.windowManager.sway;

  startupModule = lib.types.submodule {
    options = {
      command = lib.mkOption {
        type = lib.types.str;
        description = "Application that will be executed on startup.";
      };

      workspace = lib.mkOption {
        type = lib.types.number;
        description = "Workspace on which the application is started.";
      };

      appId = lib.mkOption {
        type = lib.types.str;
        description = "app_id (wayland) or instance string (xwayland) to wait for";
      };
    };
  };

  startupEntryStr = {
    command,
    workspace,
    appId,
    ...
  }: ''
    ${pkgs.sway}/bin/swaymsg 'workspace ${builtins.toString workspace}';
    ${config.home.homeDirectory}/.config/sway/sway-toolwait --waitfor '${appId}' ${command};
  '';
in {
  options.wayland.windowManager.sway.startupSync = lib.mkOption {
    type = lib.types.listOf startupModule;
    default = [];
    description = "Applications that should be launched synchronously on a specific workspace at startup.";
  };

  config = {
    home.file.".config/sway/sync-startup" = {
      executable = true;

      text = ''
        #!${pkgs.bash}/bin/bash

        ${builtins.concatStringsSep "\n" (map startupEntryStr cfg.startupSync)}
      '';
    };

    wayland.windowManager.sway.extraConfig = ''
      exec ${config.home.homeDirectory}/.config/sway/sync-startup
    '';
  };
}
