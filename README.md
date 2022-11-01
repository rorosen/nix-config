# nix-home

[Home Manager](https://nixos.wiki/wiki/Home_Manager) configuration to use on [NixOS](https://nixos.org/).

## Setup

Follow the NixOS installation as described in the [manual](https://nixos.org/manual/nixos/stable/index.html#ch-installation). Change the configuration file in `/etc/nixos/configuration.nix` so that it looks like the following. Type in the real values for the placeholders `<HOSTNAME>`, `<VIDEO_DRIVER>` and `<USERNAME>`.

```nix
{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  networking = {
    hostName = "<HOSTNAME>";
    networkmanager.enable = true;
  };

  time.timeZone = "Europe/Amsterdam";
  console.keyMap = "de-latin1";

  # unlock "login" keyring on login
  security.pam.services.login.enableGnomeKeyring = true;
  environment.pathsToLink = [ "/share/zsh" ];
  programs.dconf.enable = true;

  services.xserver = {
    enable = true;

    updateDbusEnvironment = true;
    videoDrivers = [ "<VIDEO_DRIVER>" ];

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

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.<USERNAME> = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };

  environment.systemPackages = with pkgs; [
    networkmanager
    vim
  ];

  networking.firewall.enable = false;

  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05";
}
```

Consequently, run `nixos-rebuild boot`, set a password for the user account using `passswd <USERNAME>` and `reboot` the system. Log in as the newly created user account and install Home Manager as described in the [manual](https://nix-community.github.io/home-manager/index.html#sec-install-standalone).

Once Home Manager is installed, clone this repo. You can install git temporary in a `nix-shell`, it will be installed later through Home Manager anyway.

```shell
nix-shell -p git
# clone repo in the same shell
```

Afterwards, link the repo to `$HOME/.config/nixpkgs/` and create the first Home Manager generation. Reboot the system consequently once again.

```shell
ln -s /path/to/repo $HOME/.config/nixpkgs
home-manager switch
reboot
```

## Links

- [Home Manager manual](https://nix-community.github.io/home-manager/index.html#sec-install-standalone)
- [Home Manager configuration values](https://nix-community.github.io/home-manager/options.html)
