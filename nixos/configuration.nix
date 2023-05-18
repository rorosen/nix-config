{
  pkgs,
  config,
  lib,
  ...
}: let
  isSway = config.system.flavor == "sway";
  isI3 = config.system.flavor == "i3";
in {
  options.system.flavor = lib.mkOption {
    type = lib.types.enum [
      "i3"
      "sway"
    ];
    default = "sway";
    description = "Flavor of the window manager";
  };

  config = {
    nix.settings = {
      experimental-features = ["nix-command" "flakes"];
      auto-optimise-store = true;
    };

    nixpkgs.config.allowUnfree = true;

    time.timeZone = "Europe/Berlin";
    console.keyMap = "de-latin1";

    boot = {
      tmp.cleanOnBoot = true;

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
        swaylock = lib.mkIf isSway {};
      };
    };

    sound.enable = true;

    environment.pathsToLink = ["/share/zsh"];

    environment.systemPackages = with pkgs;
      [
        networkmanager
        vim
      ]
      ++ lib.optionals isSway [
        xdg-desktop-portal
        xdg-desktop-portal-wlr
        grim
      ];

    xdg.portal = lib.mkIf isSway {
      enable = true;
      wlr.enable = true;
      extraPortals = with pkgs; [xdg-desktop-portal-wlr];
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

      xserver = lib.mkIf isI3 {
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
    };

    programs = {
      wireshark.enable = true;
      dconf.enable = true;
      xwayland.enable = lib.mkIf isSway true;
    };

    virtualisation = {
      libvirtd.enable = true;
      docker.enable = true;
    };

    hardware = {
      bluetooth.enable = true;
      opengl.enable = true;
    };

    fonts.enableDefaultFonts = true;
    fonts.fonts = with pkgs; [
      fantasque-sans-mono
      noto-fonts
      terminus_font
      material-icons
      siji
      (nerdfonts.override {fonts = ["Meslo" "Iosevka"];})
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
  };
}
