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
        "XF86AudioMute" = "exec amixer set Master toggle";
        "XF86AudioRaiseVolume" = "exec amixer set Master 4%+";
        "XF86AudioLowerVolume" = "exec amixer set Master 4%-";
        "XF86MonBrightnessDown" = "exec brightnessctl set 4%-";
        "XF86MonBrightnessUp" = "exec brightnessctl set 4%+";
        "${modifier}+d" = "exec rofi -no-config -show drun -theme ~/.config/rofi/config.rasi";
        "${modifier}+x" = "exec bash $HOME/.config/polybar/sysmenu.sh";
        "${modifier}+n" = "exec nemo";
        #"${modifier}+Shift+x" = "exec systemctl suspend";
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
          command = "i3-msg \"workspace 1; append_layout $HOME/.config/i3/workspace-1.json\"";
          notification = false;
        }
        {
          command = "i3-msg \"workspace 2; append_layout $HOME/.config/i3/workspace-2.json\"";
          notification = false;
        }
        {
          command = "i3-msg \"workspace 3; append_layout $HOME/.config/i3/workspace-3.json\"";
          notification = false;
        }
        {
          command = "i3-msg \"workspace 19; append_layout $HOME/.config/i3/workspace-19.json\"";
          notification = false;
        }
        {
          command = "i3-msg \"workspace 20; append_layout $HOME/.config/i3/workspace-20.json\"";
          notification = false;
        }
        { command = "systemctl --user restart polybar"; always = true; notification = false; }
        { command = "firefox"; notification = false; }
        { command = "code"; notification = false; }
        { command = "alacritty"; notification = false; }
        { command = "thunderbird"; notification = false; }
        { command = "keepassxc"; notification = false; }
        { command = "nextcloud"; notification = false; }
      ];
    };
  };
}
