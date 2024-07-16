{ pkgs, config, ... }:
{
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
          modules-left = [
            "sway/workspaces"
            "sway/mode"
            "sway/scratchpad"
          ];
          modules-center = [ "sway/window" ];
          modules-right = [
            "keyboard-state"
            "idle_inhibitor"
            "pulseaudio"
            "backlight"
            "battery"
            "tray"
          ];
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
              default = [
                " "
                " "
                " "
              ];
            };
            on-click = "${pkgs.pavucontrol}/bin/pavucontrol";
          };
          battery = {
            states.critical = 10;
            format = "{capacity}% {icon}";
            format-charging = "{capacity}%  ";
            format-plugged = "{capacity}%  ";
            format-alt = "{time} {icon}";
            format-icons = [
              " "
              " "
              " "
              " "
              " "
            ];
          };
          backlight = {
            format = "{percent}% {icon}";
            format-icons = [
              " "
              " "
              " "
              " "
              " "
              " "
              " "
              " "
              " "
            ];
          };
        }
        {
          name = "bottom-bar";
          layer = "top";
          position = "bottom";
          height = 22;
          spacing = 8;
          modules-left = [
            "custom/powermenu"
            "cpu"
            "memory"
            "disk"
            "temperature"
          ];
          modules-right = [
            "network"
            "clock"
          ];
          cpu.format = "  {usage}%";
          disk.format = "󰋊  {percentage_used}%";
          memory = {
            format = "  {}%";
            tooltip-format = "{used:0.1f}GiB used out of {total}";
          };
          temperature = {
            critical-threshold = 80;
            format = "{icon} {temperatureC}°C";
            format-icons = [
              " "
              " "
              " "
              " "
              " "
            ];
            hwmon-path = config.services.temp-linker.link;
            interval = 5;
          };
          clock = {
            format = "{:%H:%M}  ";
            tooltip = true;
            tooltip-format = "<tt><big>{calendar}</big></tt>";
            actions = {
              on-scroll-up = "shift_up";
              on-scroll-down = "shift_down";
            };
            calendar = {
              mode = "month";
              weeks-pos = "right";
              format = {
                days = "<span color='#ffffff'>{}</span>";
                weeks = "<span color='#99ffdd'>KW{:%W}</span>";
                weekdays = "<span color='#ffcc66'>{}</span>";
                today = "<span color = '#ff6699'>{}</span>";
              };
            };
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
