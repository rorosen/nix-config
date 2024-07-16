{ inputs, pkgs, ... }:
{
  nix = {
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

    # gc = {
    #   automatic = true;
    #   dates = "weekly";
    #   persistent = true;
    #   options = "--delete-older-than 30d";
    # };

    nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
  };

  nixpkgs.config.allowUnfree = true;

  time.timeZone = "Europe/Berlin";
  console.keyMap = "de-latin1";

  boot = {
    tmp.cleanOnBoot = true;
    binfmt.emulatedSystems = [ "aarch64-linux" ];

    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  networking = {
    networkmanager.enable = true;
    firewall.enable = false;
  };

  security = {
    rtkit.enable = true;
    polkit.enable = true;
    pam.services = {
      login.enableGnomeKeyring = true;
    };
  };

  sound.enable = true;

  environment = {
    pathsToLink = [ "/share/zsh" ];

    systemPackages = with pkgs; [
      networkmanager
      vim
    ];
  };

  services = {
    fwupd.enable = true;
    printing.enable = true;
    udisks2.enable = true;
    blueman.enable = true;

    pipewire = {
      enable = true;
      alsa.enable = true;
      jack.enable = true;
      pulse.enable = true;
    };
  };

  programs = {
    wireshark.enable = true;
    dconf.enable = true;
  };

  virtualisation = {
    libvirtd.enable = true;
    docker.enable = true;
  };

  hardware = {
    bluetooth.enable = true;
    graphics.enable = true;
  };

  fonts.enableDefaultPackages = true;
  fonts.packages = with pkgs; [
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

  i18n.defaultLocale = "en_US.utf8";
  i18n.extraLocaleSettings = {
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

  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11";
}
