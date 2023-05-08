{ pkgs, ... }:

{
  services.kanshi = {
    enable = true;

    profiles = {
      mobile = {
        exec = [
          "${pkgs.networkmanager}/bin/nmcli connection up Neuland"
        ];

        outputs = [
          {
            criteria = "eDP-1";
            mode = "1920x1200@60Hz";
            position = "0,0";
            scale = 1.0;
            status = "enable";
            transform = "normal";
          }
        ];
      };
      docked = {
        exec = [
          "${pkgs.networkmanager}/bin/nmcli connection down Neuland"
        ];

        outputs = [
          {
            criteria = "eDP-1";
            status = "disable";
          }
          {
            criteria = "DP-5";
            mode = "1920x1080@60Hz";
            position = "0,0";
            scale = 1.0;
            status = "enable";
            transform = "normal";
          }
          {
            criteria = "DP-6";
            mode = "1920x1080@60Hz";
            position = "1920,0";
            scale = 1.0;
            status = "enable";
            transform = "normal";
          }
        ];
      };
    };
  };
}
