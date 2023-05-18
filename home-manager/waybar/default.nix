{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.programs.waybar;
in {
  imports = [
    ./startup.nix
    ./hwmon-dynamic.nix
  ];

  options.programs.waybar.hwmon.path = lib.mkOption {
    type = lib.types.str;
    default = "";
    description = ''
      The temperature path to use, e.g. /sys/class/hwmon/hwmon2/temp1_input instead of one in /sys/class/thermal/.
      Only has an effect if programs.waybar.hwmon.dynamic is disabled.
    '';
  };

  config = {
    programs.waybar = {
      enable = true;
      systemd.enable = true;

      settings = [
        {
          name = "top-bar";
          layer = "top";
          position = "top";
          height = 22;
          spacing = 8;
          modules-left = ["custom/launcher" "sway/workspaces" "sway/mode" "sway/scratchpad"];
          modules-center = ["sway/window"];
          modules-right = ["keyboard-state" "idle_inhibitor" "pulseaudio" "backlight" "battery" "tray"];
          tray.spacing = 10;
          idle_inhibitor = {
            format = "{icon}";
            format-icons = {
              activated = " ";
              deactivated = " ";
            };
          };
          keyboard-state = {
            capslock = true;
            format = "{icon}";
            format-icons = {
              locked = " ";
              unlocked = "";
            };
          };
          pulseaudio = {
            format = "{volume}% {icon}  {format_source}";
            format-bluetooth = "{volume}% {icon}   {format_source}";
            format-bluetooth-muted = "   {icon}   {format_source}";
            format-muted = "   {format_source}";
            format-source = "{volume}%  ";
            format-source-muted = " ";
            format-icons = {
              headphone = " ";
              hands-free = " ";
              headset = " ";
              phone = " ";
              portable = " ";
              car = " ";
              default = [" " " " " "];
            };
            on-click = "${pkgs.pavucontrol}/bin/pavucontrol";
          };
          battery = {
            states.critical = 10;
            format = "{capacity}% {icon}";
            format-charging = "{capacity}%  ";
            format-plugged = "{capacity}%  ";
            format-alt = "{time} {icon}";
            format-icons = [" " " " " " " " " "];
          };
          backlight = {
            format = "{percent}% {icon}";
            format-icons = [" " " " " " " " " " " " " " " " " "];
          };
          "custom/launcher" = {
            on-click = "${pkgs.wofi}/bin/wofi --show=drun --allow-images --insensitive";
            format = " ";
            tooltip = false;
          };
        }
        {
          name = "bottom-bar";
          layer = "top";
          position = "bottom";
          height = 22;
          spacing = 8;
          modules-left = ["custom/powermenu" "cpu" "memory" "disk" "temperature"];
          modules-right = ["network" "clock"];
          cpu.format = "  {usage}%";
          disk.format = "󰋊  {percentage_used}%";
          memory = {
            format = "  {}%";
            tooltip-format = "{used:0.1f}GiB used out of {total}";
          };
          temperature = {
            critical-threshold = 80;
            format = "{icon} {temperatureC}°C";
            format-icons = [" " " " " " " " " "];
            hwmon-path =
              if cfg.hwmon.dynamic.enable
              then cfg.hwmon.dynamic.link
              else (lib.mkIf (cfg.hwmon.path != "") cfg.hwmon.path);
            interval = 5;
          };
          clock = {
            format = "{:%H:%M}  ";
            tooltip-format = "<big>{:%Y %B}</big>\n<tt><big>{calendar}</big></tt>";
            calendar-weeks-pos = "right";
            today-format = "<span color = '#ff6699'><u>{}</u></span>";
            format-calendar = "<span color='#ecc6d9'>{}</span>";
            format-calendar-weeks = "<span color='#99ffdd'>KW{:%V}</span>";
            format-calendar-weekdays = "<span color='#ffcc66'>{}</span>";
          };
          network = {
            interval = 1;
            min-length = 35;
            format-wifi = "  {essid}     {bandwidthDownBytes}    {bandwidthUpBytes}";
            format-ethernet = "󰈁     {bandwidthDownBytes}    {bandwidthUpBytes}";
            tooltip-format = "{ifname}: {ipaddr}/{cidr} via {gwaddr}";
            tooltip-format-wifi = "{ifname}: {ipaddr}/{cidr} via {gwaddr} ({signalStrength}%)";
            format-linked = "{ifname} (No IP)  ";
            format-disconnected = "Disconnected ⚠ ";
            on-click = "${pkgs.networkmanagerapplet}/bin/nm-connection-editor";
          };
          "custom/powermenu" = {
            on-click = "${pkgs.wlogout}/bin/wlogout";
            format = " ";
            tooltip = false;
          };
        }
      ];

      style = builtins.readFile ./style.css;
    };
  };
}
