{ pkgs, lib, ... }:

{
  imports = [
    ./layouts.nix
  ];

  xsession.windowManager.i3 = {
    enable = true;

    config = rec {
      modifier = "Mod4";
      bars = [ ];

      terminal = "${pkgs.alacritty}/bin/alacritty";

      keybindings = lib.mkOptionDefault {
        # Use selected XF86 keyboard symbols
        "XF86AudioPause" = "exec ${pkgs.playerctl}/bin/playerctl play-pause -p spotify";
        "XF86AudioPlay" = "exec ${pkgs.playerctl}/bin/playerctl play-pause -p spotify";
        "XF86AudioPrev" = "exec ${pkgs.playerctl}/bin/playerctl previous -p spotify";
        "XF86AudioNext" = "exec ${pkgs.playerctl}/bin/playerctl next -p spotify";
        "XF86AudioMute" = "exec ${pkgs.alsa-utils}/bin/amixer set Master toggle";
        "XF86AudioRaiseVolume" = "exec ${pkgs.alsa-utils}/bin/amixer set Master 8%+";
        "XF86AudioLowerVolume" = "exec ${pkgs.alsa-utils}/bin/amixer set Master 8%-";
        "XF86MonBrightnessDown" = "exec ${pkgs.brightnessctl}/bin/brightnessctl set 8%-";
        "XF86MonBrightnessUp" = "exec ${pkgs.brightnessctl}/bin/brightnessctl set 8%+";
        # Custom keybindings
        "${modifier}+d" = "exec ${pkgs.rofi}/bin/rofi -no-config -show drun -theme ~/.config/rofi/config.rasi";
        "${modifier}+x" = "exec ${pkgs.bash}/bin/bash $HOME/.config/polybar/sysmenu.sh";
        "${modifier}+n" = "exec ${pkgs.cinnamon.nemo}/bin/nemo";
        # Keybindings for additional workaspces
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

      window.titlebar = false;

      floating.criteria =
        [
          {
            class = "Nm-connection-editor";
          }
        ];

      startup = [
        {
          command = "${pkgs.i3}/bin/i3-msg \"workspace 1; append_layout $HOME/.config/i3/workspace-1.json\"";
          notification = false;
        }
        {
          command = "${pkgs.i3}/bin/i3-msg \"workspace 2; append_layout $HOME/.config/i3/workspace-2.json\"";
          notification = false;
        }
        {
          command = "${pkgs.i3}/bin/i3-msg \"workspace 3; append_layout $HOME/.config/i3/workspace-3.json\"";
          notification = false;
        }
        {
          command = "${pkgs.i3}/bin/i3-msg \"workspace 19; append_layout $HOME/.config/i3/workspace-19.json\"";
          notification = false;
        }
        {
          command = "${pkgs.i3}/bin/i3-msg \"workspace 20; append_layout $HOME/.config/i3/workspace-20.json\"";
          notification = false;
        }
        { command = "${pkgs.systemd}/bin/systemctl --user restart polybar"; always = true; notification = false; }
        { command = "${pkgs.pasystray}/bin/pasystray"; notification = false; }
        { command = "${pkgs.firefox}/bin/firefox"; notification = false; }
        { command = "${pkgs.vscode}/bin/code"; notification = false; }
        { command = "${pkgs.alacritty}/bin/alacritty"; notification = false; }
        { command = "${pkgs.thunderbird}/bin/thunderbird"; notification = false; }
        { command = "${pkgs.keepassxc}/bin/keepassxc"; notification = false; }
        { command = "${pkgs.nextcloud-client}/bin/nextcloud"; notification = false; }
      ];
    };
  };
}

