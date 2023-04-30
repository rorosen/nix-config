{ pkgs, config, lib, ... }:

let
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

  startupEntryStr = { command, workspace, appId, ... }: ''
    ${pkgs.sway}/bin/swaymsg 'workspace ${workspace}';
    ${toolwait} --waitfor '${appId}' ${command};
  '';

  toolwait = "${config.home.homeDirectory}/.config/sway/sway-toolwait";
  cfg = config.wayland.windowManager.sway;
in
{
  options.wayland.windowManager.sway.startupSync = lib.mkOption {
    type = lib.types.listOf startupModule;
    default = [ ];
    description = "Applications that should be launched synchronously on a specific workspace at startup.";
  };

  config = {
    # systemd.user.services."sway-start-apps" = {
    #   Unit = {
    #     Description = "synchronously start sway aplications";
    #   };

    #   Service = {
    #     Type = "forking";
    #     ExecStart = "${config.home.homeDirectory}/.config/sway/start-apps";
    #   };

    #   Install = {
    #     WantedBy = [ "sway-session.target" ];
    #   };
    # };

    home.file.".config/sway/sync-startup" = {
      executable = true;

      text = ''
        #!${pkgs.bash}/bin/bash

        # ''${builtins.concatStringsSep "\n" map startupEntryStr cfg.startupSync}

        # ${pkgs.sway}/bin/swaymsg 'workspace 1';
        # ${toolwait} --waitfor 'firefox' ${pkgs.firefox}/bin/firefox;
        # ${pkgs.sway}/bin/swaymsg 'workspace 3';
        # ${toolwait} --waitfor 'Alacritty' ${pkgs.alacritty}/bin/alacritty;
        # ${pkgs.sway}/bin/swaymsg 'workspace 20';
        # ${toolwait} --waitfor 'org.keepassxc.KeePassXC' ${pkgs.keepassxc}/bin/keepassxc;
        # ${pkgs.sway}/bin/swaymsg 'workspace 2';
        # #TODO: start vscode as native wayland application (https://github.com/microsoft/vscode/issues/146349)
        # #${toolwait} --nocheck ${pkgs.vscode}/bin/code;
      '';
    };
  };
}
