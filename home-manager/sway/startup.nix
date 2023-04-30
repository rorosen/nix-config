{ pkgs, config, ... }:

let
  toolwait = "${config.home.homeDirectory}/.config/sway/sway-toolwait";
in
{
  systemd.user.services."sway-start-apps" = {
    Unit = {
      Description = "start sway aplications";
    };

    Service = {
      Type = "simple";
      Environment = [ "DISPLAY=:0" ];
      ExecStart = "${config.home.homeDirectory}/.config/sway/start-apps";
    };

    Install = {
      WantedBy = [ "sway-session.target" ];
    };
  };

  home.file.".config/sway/start-apps" = {
    executable = true;

    text = ''
      #!${pkgs.bash}/bin/bash

      ${pkgs.sway}/bin/swaymsg 'workspace 1';
      ${toolwait} --waitfor 'firefox' ${pkgs.firefox}/bin/firefox;
      ${pkgs.sway}/bin/swaymsg 'workspace 3';
      ${toolwait} --waitfor 'Alacritty' ${pkgs.alacritty}/bin/alacritty;
      ${pkgs.sway}/bin/swaymsg 'workspace 20';
      ${toolwait} --waitfor 'org.keepassxc.KeePassXC' ${pkgs.keepassxc}/bin/keepassxc;
      ${pkgs.sway}/bin/swaymsg 'workspace 2';
      #TODO: start vscode as native wayland application (https://github.com/microsoft/vscode/issues/146349)
      ${toolwait} --nocheck ${pkgs.vscode}/bin/code;
    '';
  };
}
