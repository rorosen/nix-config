{ ... }:

{
  home.file.".config/waybar/auxbar".text = ''
    "name": "auxbar",
    "layer": "top",
    "height": 26,
    "spacing": 8,
    "modules-left": [
      "sway/workspaces"
    ],
    "modules-center": [
      "sway-window"
    ]
  '';
}
