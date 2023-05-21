{...}: {
  home.file.".config/i3/workspace-1.json" = {
    target = ".config/i3/workspace-1.json";

    text = ''
      {
        "border": "pixel",
        "current_border_width": 2,
        "floating": "auto_off",
        "geometry": {
          "height": 1020,
          "width": 1916,
          "x": 0,
          "y": 0
        },
        "marks": [],
        //   "name": "",
        "percent": 1,
        "swallows": [
          {
            "class": "^firefox$",
            "instance": "^Navigator$",
            // "machine": "^hp$",
            // "title": "^i3\\:\\ Layout\\ saving\\ in\\ i3\\ \\—\\ Mozilla\\ Firefox$",
            "window_role": "^browser$"
          }
        ],
        "type": "con"
      }
    '';
  };

  home.file.".config/i3/workspace-2.json" = {
    target = ".config/i3/workspace-2.json";

    text = ''
      {
        "border": "pixel",
        "current_border_width": 2,
        "floating": "auto_off",
        "geometry": {
          "height": 1020,
          "width": 1916,
          "x": 2,
          "y": 30
        },
        "marks": [],
        //  "name": "i3.nix - nixfiles - Visual Studio Code",
        "percent": 1,
        "swallows": [
          {
            "class": "^Code$",
            "instance": "^code$",
            // "machine": "^hp$",
            // "title": "^i3\\.nix\\ \\-\\ nixfiles\\ \\-\\ Visual\\ Studio\\ Code$",
            "window_role": "^browser\\-window$"
          }
        ],
        "type": "con"
      }
    '';
  };

  home.file.".config/i3/workspace-3.json" = {
    target = ".config/i3/workspace-3.json";

    text = ''
      {
        "border": "pixel",
        "current_border_width": 2,
        "floating": "auto_off",
        "geometry": {
          "height": 1589,
          "width": 1000,
          "x": 0,
          "y": 0
        },
        "marks": [],
        //   "name": "Terminal",
        "percent": 1,
        "swallows": [
          {
            "class": "^Alacritty$",
            "instance": "^Alacritty$",
            // "machine": "^hp$",
            "title": "^Terminal$"
          }
        ],
        "type": "con"
      }
    '';
  };

  home.file.".config/i3/workspace-19.json" = {
    target = ".config/i3/workspace-19.json";

    text = ''
      {
        "border": "pixel",
        "current_border_width": 2,
        "floating": "auto_off",
        "geometry": {
          "height": 1020,
          "width": 1916,
          "x": 0,
          "y": 0
        },
        "marks": [],
        //  "name": "Inbox - Mozilla Thunderbird",
        "percent": 1,
        "swallows": [
          {
            "class": "^thunderbird$",
            "instance": "^Mail$",
            // "machine": "^hp$",
            // "title": "^Inbox\\ \\-\\ Mozilla\\ Thunderbird$",
            "window_role": "^3pane$"
          }
        ],
        "type": "con"
      }
    '';
  };

  home.file.".config/i3/workspace-20.json" = {
    target = ".config/i3/workspace-20.json";

    text = ''
      {
        "border": "pixel",
        "current_border_width": 2,
        "floating": "auto_off",
        "geometry": {
          "height": 1020,
          "width": 1916,
          "x": 2,
          "y": 30
        },
        "marks": [],
        //  "name": "login_priv.kdbx [Locked] - KeePassXC",
        "percent": 1,
        "swallows": [
          {
            "class": "^KeePassXC$",
            "instance": "^keepassxc$",
            // "machine": "^hp$",
            // "title": "^login_priv\\.kdbx\\ \\[Locked\\]\\ \\-\\ KeePassXC$"
          }
        ],
        "type": "con"
      }
    '';
  };
}
