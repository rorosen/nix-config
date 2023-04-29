{ pkgs, ... }:

{
  imports = [
    ./configuration.nix
    ./hp-hardware-configuration.nix
  ];

  networking.hostName = "hp";
  boot.initrd.kernelModules = [ "amdgpu" ];

  # Enable scanner support
  hardware.sane = {
    enable = true;
    extraBackends = [ pkgs.sane-airscan ];
  };

  users.users.rob.extraGroups = [ "scanner" ];

  hardware.logitech.wireless = {
    enable = true;
    enableGraphical = true;
  };

  services.xserver = {
    enable = true;
    updateDbusEnvironment = true;
    videoDrivers = [ "amdgpu" ];

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
