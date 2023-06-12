{
  pkgs,
  lib,
  ...
}: let
  modifier = "Mod4";
in {
  imports = [
    ./autostart.nix
  ];

  wayland.windowManager.sway = {
    enable = true;
    systemd.enable = true;

    autostart = [
      {
        command = "${pkgs.vscode}/bin/code";
        workspace = 2;
        waitFor = "code";
      }
      {
        command = "${pkgs.firefox}/bin/firefox";
        workspace = 1;
        waitFor = "firefox";
      }
      {
        command = "${pkgs.alacritty}/bin/alacritty";
        workspace = 3;
        waitFor = "Alacritty";
      }
      {
        command = "${pkgs.keepassxc}/bin/keepassxc";
        workspace = 20;
        waitFor = "org.keepassxc.KeePassXC";
      }
    ];

    extraConfigEarly = ''
      for_window [class=".*"] inhibit_idle fullscreen
      for_window [app_id=".*"] inhibit_idle fullscreen
    '';

    config = {
      modifier = modifier;
      bars = [];
      terminal = "${pkgs.alacritty}/bin/alacritty";
      workspaceAutoBackAndForth = true;
      window = {
        titlebar = false;
      };

      input = {
        "*" = {
          xkb_layout = "de";
          xkb_numlock = "enabled";
        };

        "type:touchpad" = {
          dwt = "enabled";
          tap = "enabled";
          middle_emulation = "enabled";
          natural_scroll = "enabled";
        };
      };

      keybindings = lib.mkOptionDefault {
        # Use selected XF86 keyboard symbols
        "XF86AudioMute" = "exec ${pkgs.alsa-utils}/bin/amixer set Master toggle";
        "XF86AudioRaiseVolume" = "exec ${pkgs.alsa-utils}/bin/amixer set Master 8%+";
        "XF86AudioLowerVolume" = "exec ${pkgs.alsa-utils}/bin/amixer set Master 8%-";
        "XF86MonBrightnessDown" = "exec ${pkgs.brightnessctl}/bin/brightnessctl set 8%-";
        "XF86MonBrightnessUp" = "exec ${pkgs.brightnessctl}/bin/brightnessctl set 8%+";
        # Custom keybindings
        "${modifier}+d" = "exec ${pkgs.wofi}/bin/wofi --show=drun --allow-images --insensitive";
        "${modifier}+x" = "exec ${pkgs.wlogout}/bin/wlogout";
        "${modifier}+n" = "exec ${pkgs.cinnamon.nemo}/bin/nemo";
        "${modifier}+less" = "move workspace to output left";
        # Keybindings for additional workaspces
        "${modifier}+0" = "workspace number 10";
        "${modifier}+Ctrl+1" = "workspace number 11";
        "${modifier}+Ctrl+2" = "workspace number 12";
        "${modifier}+Ctrl+3" = "workspace number 13";
        "${modifier}+Ctrl+4" = "workspace number 14";
        "${modifier}+Ctrl+5" = "workspace number 15";
        "${modifier}+Ctrl+6" = "workspace number 16";
        "${modifier}+Ctrl+7" = "workspace number 17";
        "${modifier}+Ctrl+8" = "workspace number 18";
        "${modifier}+Ctrl+9" = "workspace number 19";
        "${modifier}+Ctrl+0" = "workspace number 20";
        "${modifier}+Shift+0" = "move container to workspace number 10";
        "${modifier}+Shift+Ctrl+1" = "move container to workspace number 11";
        "${modifier}+Shift+Ctrl+2" = "move container to workspace number 12";
        "${modifier}+Shift+Ctrl+3" = "move container to workspace number 13";
        "${modifier}+Shift+Ctrl+4" = "move container to workspace number 14";
        "${modifier}+Shift+Ctrl+5" = "move container to workspace number 15";
        "${modifier}+Shift+Ctrl+6" = "move container to workspace number 16";
        "${modifier}+Shift+Ctrl+7" = "move container to workspace number 17";
        "${modifier}+Shift+Ctrl+8" = "move container to workspace number 18";
        "${modifier}+Shift+Ctrl+9" = "move container to workspace number 19";
        "${modifier}+Shift+Ctrl+0" = "move container to workspace number 20";
      };

      floating.criteria = [
        {app_id = "nm-connection-editor";}
      ];
    };
  };
}
