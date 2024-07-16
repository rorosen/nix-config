{
  config,
  pkgs,
  lib,
  ...
}:
with lib;
let
  # --------- COLORS ---------
  background = "#0a0a0a";
  foreground = "#f5f5f5";
  foreground-alt = "#33f5f5f5";
  primary = "#fdd835";
  red = "#FF5250";
  green = "#006600";
  yellow = "#fdd835";

  cfg = config.services.polybar;
in
{
  imports = [
    ./sysmenu.nix
    ./spotify-status.nix
  ];

  options.services.polybar = {
    tempHwmonPath = mkOption {
      default = "";
      type = types.str;
      description = "
        Full path of temperature sysfs path.
        ";
    };

    backlightCard = mkOption {
      default = "";
      type = types.str;
      description = "      
        Backlight card to use.
      ";
    };

    battery = mkOption {
      default = "";
      type = types.str;
      description = "      
        Battery to use.
      ";
    };

    spotify.enabled = mkOption {
      default = true;
      type = types.bool;
      description = "
        Whether the spotfy (playerctl) modules should be enabled. Default true.
      ";
    };

    network = {
      interfaceWired = mkOption {
        default = "";
        type = types.str;
        description = "      
          Wired interface name. Leave empty if disabled. Default \"\".
        ";
      };

      interfaceWireless = mkOption {
        default = "";
        type = types.str;
        description = "      
          Wireless interface name. Leave empty if disabled. Default \"\".
        ";
      };
    };
  };

  config = {
    services.polybar = {
      enable = true;

      script = ''
        polybar top &
        polybar bottom &
      '';

      settings = {
        "settings" = {
          screenchange.reload = false;
          pseudo.transparency = false;
          compositing = {
            background = "source";
            foreground = "over";
            overline = "over";
            underline = "over";
            border = "over";
          };
        };

        "gloabl/wm" = {
          margin.bottom = 0;
          margin-top = 0;
        };

        "bar" = {
          fill = "ﭳ ";
          empty = "ﭳ ";
          indicator = "";
          width = 6;
          format = "%{T4}%fill%%indicator%%empty%%{F-}%{T-}";
        };

        # --------- BARS ---------

        "bar/main" = {
          monitor.strict = false;
          override.redirect = false;
          bottom = false;
          fixed.center = true;
          width = "100%";
          height = "28";
          offset = {
            x = "0%";
            y = "0%";
          };
          background = background;
          foreground = foreground;
          radius = {
            top = "0.0";
            bottom = "0.0";
          };
          line = {
            size = 2;
            color = primary;
          };
          border = {
            size = 0;
            color = primary;
          };
          padding = 0;
          module.margin = {
            left = 0;
            right = 0;
          };
          # Fonts are defined using <font-name>;<vertical-offset>
          font = [
            "Iosevka Nerd Font:style=Medium:size=10;4"
            "Iosevka Nerd Font:style=Medium:size=19;3"
            "Iosevka Nerd Font:style=Medium:size=12;4"
            "Iosevka Nerd Font:style=Medium:size=7;4"
          ];
        };

        "bar/top" = {
          "inherit" = "bar/main";
          enable.ipc = true;
          modules = {
            left = "launcher title workspaces";
            right =
              "volume "
              + (if cfg.backlightCard == "" then "" else "brightness ")
              + "temperature "
              + (if cfg.battery == "" then "" else "battery ")
              + "keyboard date";
          };
        };

        "bar/bottom" = {
          "inherit" = "bar/main";
          enable.ipc = true;
          bottom = true;
          tray = {
            position = "center";
            detached = false;
            maxsize = 16;
            background = background;
            padding = 0;
            scale = "1.0";
            offset = {
              x = 0;
              y = 0;
            };
          };
          modules = {
            left =
              (if cfg.spotify.enabled then "spotify-status spotify-prev spotify-play-pause spotify-next " else "")
              + "cpu memory filesystem";
            right =
              (if cfg.network.interfaceWired == "" then "" else "network-wired ")
              + (if cfg.network.interfaceWireless == "" then "" else "network-wireless ")
              + "sysmenu";
          };
        };

        # --------- MODULES TOP ---------

        "module/launcher" = {
          type = "custom/text";
          click.left = "${pkgs.rofi}/bin/rofi -no-config -show drun -theme $HOME/.config/rofi/config.rasi";
          content = {
            text = " ";
            background = background;
            foreground = primary;
            padding = 2;
          };
        };

        "module/title" = {
          type = "internal/xwindow";
          format = {
            text = "<label>";
            background = background;
            padding = 0;
          };
          label = {
            text = "%title%";
            minlen = 40;
            maxlen = 40;
            # Used instead of label when there is no window title (40 spaces)
            empty = "                                        ";
          };
        };

        "module/workspaces" = {
          type = "internal/xworkspaces";
          pin.workspaces = true;
          enable = {
            click = true;
            scroll = false;
          };
          icon = [
            "1;1"
            "2;2"
            "3;3"
            "4;4"
            "5;5"
            "6;6"
            "7;7"
            "8;8"
            "9;9"
            "10;10"
            "11;11"
            "12;12"
            "13;13"
            "14;14"
            "15;15"
            "16;16"
            "17;17"
            "18;18"
            "19;19"
            "20;20"
          ];
          format = {
            text = "<label-state>";
            background = background;
            padding = 0;
          };
          label = {
            monitor = "%name%";
            active = {
              text = "%icon%";
              foreground = red;
              overline = red;
              padding = 1;
            };
            occupied = {
              text = "%icon%";
              foreground = yellow;
              padding = 1;
            };
            urgent = {
              text = "%icon%";
              foreground = green;
              overline = green;
              padding = 1;
            };
            empty = {
              text = "%icon%";
              foreground = yellow;
              padding = 1;
            };
          };
        };

        "module/temperature" = {
          type = "internal/temperature";
          interval = 1;
          thermal.zone = 0;
          hwmon.path = cfg.tempHwmonPath;
          warn.temperature = 65;
          base.temperature = 20;
          units = true;
          format = {
            text = "<ramp> <label>";
            background = background;
            padding = 1;
            warn = {
              text = "<ramp> <label-warn>";
              background = background;
              padding = 1;
            };
          };
          label = {
            text = "%temperature-c%";
            warn = {
              text = "%temperature-c%";
              foreground = red;
            };
          };
          ramp = [
            ""
            ""
            ""
            ""
            ""
          ];
        };

        "module/battery" = {
          type = "internal/battery";
          full.at = 99;
          battery = cfg.battery;
          adapter = "ACAD";
          poll.interval = 2;
          time.format = "%H:%M";
          format = {
            charging = {
              text = "<label-charging>";
              prefix = "  ";
              background = background;
              padding = 1;
            };
            discharging = {
              text = "<ramp-capacity> <label-discharging>";
              background = background;
              padding = 1;
            };
            full = {
              text = "<label-full>";
              prefix = "   ";
              background = background;
              padding = 1;
            };
          };
          label = {
            charging = "%percentage%%";
            discharging = "%percentage%%";
            full = "Full";
          };
          ramp.capacity = [
            "  "
            "  "
            "  "
            "  "
            "  "
          ];
        };

        "module/keyboard" = {
          type = "internal/xkeyboard";
          blacklist = [
            "num lock"
            "scroll lock"
          ];
          format = {
            text = "<label-layout> <label-indicator>";
            background = background;
            padding = 1;
            prefix = " ";
          };
          label = {
            layout = " %layout%";
            indicator.on = {
              text = "%name%";
              foreground = primary;
            };
          };
        };

        "module/date" = {
          type = "internal/date";
          interval = 1;
          label = "%time%";
          time = {
            text = "  %H:%M";
            alt = "  %a, %d %b %Y";
          };
          format = {
            text = "<label>";
            background = background;
            padding = 1;
          };
        };

        "module/volume" = {
          type = "internal/alsa";
          interval = 5;
          master = {
            mixer = "Master";
            soundcard = "default";
          };
          speaker.soundcard = "default";
          headphone.soundcard = "default";
          format = {
            volume = {
              text = "<ramp-volume> <bar-volume>";
              background = background;
              padding = 2;
            };
            muted = {
              text = "<label-muted>";
              prefix = " ";
              background = background;
              padding = 2;
            };
          };
          label = {
            volume = "%percentage%%";
            muted = {
              text = " Muted";
              foreground = foreground;
            };
          };
          ramp.volume = [
            " "
            " "
            " "
          ];
          bar.volume = {
            format = "\${bar.format}";
            width = "\${bar.width}";
            gradient = false;
            indicator = {
              text = "\${bar.indicator}";
              foreground = foreground;
            };
            fill = "\${bar.fill}";
            foreground = [ yellow ];
            empty = {
              text = "\${bar.empty}";
              foreground = foreground-alt;
            };
          };
        };

        "module/brightness" = {
          type = "internal/backlight";
          card = cfg.backlightCard;
          label = "%percentage%%";
          format = {
            text = "<ramp> <bar>";
            background = background;
            padding = 2;
          };
          ramp = [
            " "
            " "
            " "
          ];
          bar = {
            format = "\${bar.format}";
            width = "\${bar.width}";
            gradient = false;
            fill = "\${bar.fill}";
            foreground = [ yellow ];
            indicator = {
              text = "\${bar.indicator}";
              foreground = foreground;
            };
            empty = {
              text = "\${bar.empty}";
              foreground = foreground-alt;
            };
          };
        };

        "module/sysmenu" = {
          type = "custom/text";
          content = {
            text = " ";
            background = background;
            foreground = primary;
            padding = 1;
          };
          click.left = "${pkgs.bash}/bin/bash $HOME/.config/polybar/sysmenu.sh";
        };

        # --------- MODULES BOTTOM ---------

        "module/spotify-status" = {
          type = "custom/script";
          interval = 1;
          format = {
            text = "<label>";
            prefix = " 阮  ";
            background = background;
            padding = 2;
          };
          label.maxlen = 50;
          exec = "${pkgs.bash}/bin/bash $HOME/.config/polybar/spotify-status.sh";
        };

        "module/spotify-play-pause" = {
          type = "custom/ipc";
          hook = [
            "echo \"  \""
            "echo \"  \""
          ];
          initial = 1;
          format = {
            background = background;
            foreground = primary;
          };
          click.left = "${pkgs.playerctl}/bin/playerctl play-pause -p spotify";
        };

        "module/spotify-prev" = {
          type = "custom/text";
          content = {
            text = "ﭣ  ";
            background = background;
            foreground = foreground;
            padding = 1;
          };
          click.left = "${pkgs.playerctl}/bin/playerctl previous -p spotify";
        };

        "module/spotify-next" = {
          type = "custom/text";
          content = {
            text = "ﭡ  ";
            background = background;
            foreground = foreground;
            padding = 1;
          };
          click.left = "${pkgs.playerctl}/bin/playerctl next -p spotify";
        };

        "module/cpu" = {
          type = "internal/cpu";
          interval = 1;
          label = "%percentage%%";
          format = {
            text = "<label>";
            prefix = " ";
            background = background;
            padding = 2;
          };
        };

        "module/memory" = {
          type = "internal/memory";
          interval = 1;
          label = "%gb_used%";
          format = {
            text = "<label>";
            prefix = "  ";
            background = background;
            padding = 2;
          };
        };

        "module/filesystem" = {
          type = "internal/fs";
          mount = [ "/" ];
          interval = 30;
          fixed.values = true;
          label = {
            mounted = "%free%";
            unmounted = " %mountpoint%: not mounted";
          };
          format = {
            mounted = {
              text = "<label-mounted>";
              prefix = " ";
              background = background;
              padding = 2;
            };
            unmounted = {
              text = "<label-unmounted>";
              prefix = " ";
              background = background;
              padding = 2;
            };
          };
        };

        "module/network" = {
          type = "internal/network";
          interval = 1;
          accumulate-stats = true;
          unknown-as-up = true;
          label = {
            connected = "%{A1:${pkgs.networkmanagerapplet}/bin/nm-connection-editor:} %essid% - %local_ip%    %downspeed%   %upspeed%%{A}";
            disconnected = "%{A1:${pkgs.networkmanagerapplet}/bin/nm-connection-editor:} Offline%{A}";
          };
        };

        "module/network-wired" = {
          "inherit" = "module/network";
          interface = cfg.network.interfaceWired;
          format = {
            connected = {
              text = "<label-connected>";
              prefix = " ";
              background = background;
              padding = 2;
            };
            disconnected = {
              text = "<label-disconnected>";
              prefix = " ";
              background = background;
              padding = 2;
            };
          };
        };

        "module/network-wireless" = {
          "inherit" = "module/network";
          interface = cfg.network.interfaceWireless;
          format = {
            connected = {
              text = "<label-connected>";
              prefix = "直 ";
              background = background;
              padding = 2;
            };
            disconnected = {
              text = "<label-disconnected>";
              prefix = "睊 ";
              background = background;
              padding = 2;
            };
          };
        };
      };
    };
  };
}
