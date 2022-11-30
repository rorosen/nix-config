# nix-home

[Home Manager](https://nixos.wiki/wiki/Home_Manager) configuration to use on [NixOS](https://nixos.org/).

## Setup

Follow the NixOS installation as described in the [manual](https://nixos.org/manual/nixos/stable/index.html#ch-installation). Change the configuration file in `/etc/nixos/configuration.nix` so that it looks like the following. Type in the real values for the placeholders `<HOSTNAME>` and `<VIDEO_DRIVER>`.

```nix
{ config, pkgs, lib, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      <home-manager/nixos>
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  # Clean tmp on boot
  boot.cleanTmpDir = true;

  networking = {
    hostName = "<HOSTNAME>";
    networkmanager.enable = true;
    firewall.enable = false;
  };

  environment.systemPackages = with pkgs; [
    networkmanager
    vim
  ];

  time.timeZone = "Europe/Berlin";
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
  services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Enable scanner support
  hardware.sane = {
    enable = true;
    extraBackends = [ pkgs.sane-airscan ];
  };

  virtualisation = {
    libvirtd.enable = true;
    docker.enable = true;
  };

  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05";

  fonts.fonts = with pkgs; [
    fantasque-sans-mono
    noto-fonts
    terminus_font
    material-icons
    siji
    (nerdfonts.override { fonts = [ "Meslo" "Iosevka" ]; })
  ];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.rob = {
    isNormalUser = true;
    extraGroups = [ "wheel" "libvirtd" "docker" "cups" "scanner" "lp" ];
  };

  home-manager.users.rob = { ... }: {
    nixpkgs.config.allowUnfree = true;
    imports = [ ./user/home.nix ];
  };
}
```

Consequently, clone this repo and link its [user](./user) directory to `/etc/nixos/user`.

```shell
nix-shell -p git
git clone ...
sudo ln -s /path/to/repo/user /etc/nixos/user
```

Run `nixos-rebuild switch` and set a password for the user account using `passswd <USERNAME>`.

## Links

- [Home Manager manual](https://nix-community.github.io/home-manager/index.html#sec-install-standalone)
- [Home Manager configuration values](https://nix-community.github.io/home-manager/options.html)
