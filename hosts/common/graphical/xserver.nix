{pkgs, ...}: {
  services.xserver = {
    enable = true;

    updateDbusEnvironment = true;

    libinput = {
      enable = true;

      touchpad = {
        disableWhileTyping = true;
        naturalScrolling = true;
      };
    };

    desktopManager.session = [
      {
        name = "xsession";
        start = "${pkgs.runtimeShell} $HOME/.xsession & waitPID=$!";
      }
    ];
  };
}
