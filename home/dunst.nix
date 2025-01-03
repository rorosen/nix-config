{
  services.dunst = {
    enable = true;
    settings = {
      global = {
        follow = "mouse";
        width = 300;
        height = 300;
        offset = "30x50";
        origin = "top-right";
        transparency = 10;
        frame_width = 1;
        frame_color = "#c9545d";
        corner_radius = 10;
        font = "Droid Sans 9";
      };

      urgency_normal = {
        background = "#37474f";
        foreground = "#eceff1";
        timeout = 5;
      };
    };
  };
}
