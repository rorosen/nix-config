{pkgs, ...}: {
  gtk = {
    enable = true;
    theme = {
      package = pkgs.gnome-themes-extra;
      name = "Adwaita-dark";
    };
    cursorTheme = {
      name = "Adwaita";
    };
  };

  home.sessionVariables = {
    XCURSOR_THEME = "Adwaita";
  };
}
