{ pkgs, ... }:

{
  programs.waybar = {
    enable = true;
    systemd.enable = true;

    settings = [
      {
        name = "top-bar";
        layer = "top";
        position = "top";
        height = 30;
        spacing = 6;
        modules-left = [ "sway/workspaces" "sway/mode" "sway/scratchpad" ];
        modules-center = [ "sway/window" ];
        modules-right = [ "idle_inhibitor" "pulseaudio" "backlight" "battery" "tray" ];
        tray.spacing = 10;
        idle_inhibitor = {
          format = "{icon}";
          format-icons = {
            activated = " ";
            deactivated = " ";
          };
        };
        pulseaudio = {
          format = "{volume}% {icon}  {format_source}";
          format-bluetooth = "{volume}% {icon}  {format_source}";
          format-bluetooth-muted = "  {icon}  {format_source}";
          format-muted = "  {format_source}";
          format-source = "{volume}%  ";
          format-source-muted = " ";
          format-icons = {
            headphone = " ";
            hands-free = " ";
            headset = " ";
            phone = " ";
            portable = " ";
            car = " ";
            default = [ " " " " " " ];
          };
          on-click = "${pkgs.pavucontrol}/bin/pavucontrol";
        };
        battery = {
          states.critical = 10;
          format = "{capacity}% {icon}";
          format-charging = "{capacity}%  ";
          format-plugged = "{capacity}%  ";
          format-alt = "{time} {icon}";
          format-icons = [ " " " " " " " " " " ];
        };
        backlight = {
          format = "{percent}% {icon}";
          format-icons = [ " " " " " " " " " " " " " " " " " " ];
        };
      }
      {
        name = "bottom-bar";
        layer = "top";
        position = "bottom";
        height = 30;
        spacing = 6;
        modules-left = [ "cpu" "memory" "disk" "temperature" ];
        modules-right = [ "network" "sway/language" "clock" ];
        cpu.format = "  {usage}%";
        memory.format = "  {}%";
        disk.format = "   {percentage_used}%";
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
          format-wifi = "{essid}  ";
          format-ethernet = " ";
          tooltip-format = "{ifname}: {ipaddr}/{cidr} via {gwaddr}";
          format-linked = "{ifname} (No IP)  ";
          format-disconnected = "Disconnected ⚠ ";
          on-click = "${pkgs.networkmanagerapplet}/bin/nm-connection-editor";
        };
        temperature = {
          critical-threshold = 80;
          format = "{icon} {temperatureC}°C";
          format-icons = [ " " " " " " " " " " ];
        };
      }
    ];

    style = builtins.readFile ./style.css;
  };
}
