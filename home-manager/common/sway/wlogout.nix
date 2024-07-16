{ pkgs, ... }:
{
  programs.wlogout = {
    enable = true;

    layout = [
      {
        label = "lock";
        action = "${pkgs.swaylock}/bin/swaylock --daemonize";
        text = "Lock";
        keybind = "l";
      }
      {
        label = "shutdown";
        action = "${pkgs.systemd}/bin/systemctl poweroff";
        text = "Shutdown";
        keybind = "s";
      }
      {
        label = "reboot";
        action = "${pkgs.systemd}/bin/systemctl reboot";
        text = "Reboot";
        keybind = "r";
      }
      {
        label = "suspend";
        action = "${pkgs.systemd}/bin/systemctl suspend";
        text = "Suspend";
        keybind = "u";
      }
      {
        label = "logout";
        action = "${pkgs.systemd}/bin/loginctl terminate-user $USER";
        text = "Logout";
        keybind = "e";
      }
      {
        label = "hibernate";
        action = "${pkgs.systemd}/bin/systemctl hibernate";
        text = "Hibernate";
        keybind = "h";
      }
    ];

    style = ''
      * {
      	background-image: none;
      }
      window {
      	background-color: rgba(12, 12, 12, 0.9);
        border-radius: 10px;
      }
      button {
        color: #FFFFFF;
      	background-color: #1E1E1E;
      	border-style: solid;
      	border-width: 2px;
      	background-repeat: no-repeat;
      	background-position: center;
      	background-size: 25%;
      }

      button:focus, button:active {
      	background-color: #c9545d;
      	outline-style: none;
      }

      #lock {
          background-image: image(url("${pkgs.wlogout}/share/wlogout/icons/lock.png"), url("/usr/local/share/wlogout/icons/lock.png"));
      }

      #logout {
          background-image: image(url("${pkgs.wlogout}/share/wlogout/icons/logout.png"), url("/usr/local/share/wlogout/icons/logout.png"));
      }

      #suspend {
          background-image: image(url("${pkgs.wlogout}/share/wlogout/icons/suspend.png"), url("/usr/local/share/wlogout/icons/suspend.png"));
      }

      #hibernate {
          background-image: image(url("${pkgs.wlogout}/share/wlogout/icons/hibernate.png"), url("/usr/local/share/wlogout/icons/hibernate.png"));
      }

      #shutdown {
          background-image: image(url("${pkgs.wlogout}/share/wlogout/icons/shutdown.png"), url("/usr/local/share/wlogout/icons/shutdown.png"));
      }

      #reboot {
          background-image: image(url("${pkgs.wlogout}/share/wlogout/icons/reboot.png"), url("/usr/local/share/wlogout/icons/reboot.png"));
      }
    '';
  };
}
