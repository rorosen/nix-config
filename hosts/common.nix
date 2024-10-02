{ inputs, pkgs, ... }:
{
  boot = {
    tmp.cleanOnBoot = true;
    binfmt.emulatedSystems = [ "aarch64-linux" ];
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  environment.pathsToLink = [ "/share/zsh" ];
  nixpkgs.config.allowUnfree = true;
  nix = {
    nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
    package = pkgs.lix;
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      auto-optimise-store = true;
    };

    extraOptions = ''
      keep-outputs = true
      keep-derivations = true
    '';
  };

  xdg.portal = {
    enable = true;
    wlr.enable = true;
    lxqt.enable = true;

    config.common.default = "*";
    extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];
  };

  networking = {
    networkmanager.enable = true;
    firewall.enable = false;
  };

  security = {
    rtkit.enable = true;
    polkit.enable = true;
    pam.services = {
      # Needed by swaylock (home-manager)
      swaylock = { };
      login.enableGnomeKeyring = true;
    };
  };

  services = {
    blueman.enable = true;
    fwupd.enable = true;
    udisks2.enable = true;
    pipewire = {
      enable = true;
      alsa.enable = true;
      jack.enable = true;
      pulse.enable = true;
    };
    printing.enable = true;
  };

  programs = {
    xwayland.enable = true;
    wireshark.enable = true;
    dconf.enable = true;
  };

  virtualisation = {
    libvirtd.enable = true;
    podman = {
      enable = true;
      dockerCompat = true;
      dockerSocket.enable = true;
    };
  };

  hardware = {
    bluetooth.enable = true;
    graphics.enable = true;
  };

  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      fantasque-sans-mono
      noto-fonts
      terminus_font
      material-icons
      siji
      (nerdfonts.override {
        fonts = [
          "Meslo"
          "Iosevka"
        ];
      })
    ];
  };

  console.keyMap = "de-latin1";
  time.timeZone = "Europe/Berlin";
  i18n = {
    defaultLocale = "en_US.utf8";
    extraLocaleSettings = {
      LC_ADDRESS = "de_DE.utf8";
      LC_IDENTIFICATION = "de_DE.utf8";
      LC_MEASUREMENT = "de_DE.utf8";
      LC_MONETARY = "de_DE.utf8";
      LC_NAME = "de_DE.utf8";
      LC_NUMERIC = "de_DE.utf8";
      LC_PAPER = "de_DE.utf8";
      LC_TELEPHONE = "de_DE.utf8";
      LC_TIME = "de_DE.utf8";
    };
  };

  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11";
}
