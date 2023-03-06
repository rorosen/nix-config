{ config, pkgs, lib, ... }:

{
  imports =
    [
      /etc/nixos/hardware-configuration.nix
      ./system-extras.nix
      <home-manager/nixos>
    ];

  # Enable flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Use the systemd-boot EFI boot loader.
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  # Clean tmp on boot
  boot.cleanTmpDir = true;

  networking = {
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

  services.udisks2.enable = true;
  programs.gnome-disks.enable = true;

  security.rtkit.enable = true;
  hardware.pulseaudio.enable = true;
  sound.enable = true;

  # services.pipewire = {
  #   enable = true;
  #   alsa.enable = true;
  #   jack.enable = true;
  #   pulse.enable = true;
  #   # wireplumber.enable = false;
  # };

  # Enable scanner support
  hardware.sane = {
    enable = true;
    extraBackends = [ pkgs.sane-airscan ];
  };

  programs.wireshark.enable = true;

  virtualisation = {
    libvirtd.enable = true;
    docker.enable = true;
  };

  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11";

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
    extraGroups = [ "wheel" "libvirtd" "docker" "cups" "scanner" "lp" "audio" "wireshark" ];
  };

  nix.nixPath = [
    "/home/rob/.nix-defexpr/channels"
    "nixpkgs=/nix/var/nix/profiles/per-user/root/channels/nixos"
    "nixos-config=/home/rob/misc/nix-config/configuration/configuration.nix"
    "/nix/var/nix/profiles/per-user/root/channels"
  ];

  home-manager.users.rob = { ... }: {
    nixpkgs.config.allowUnfree = true;

    imports = [
      ./user
      ./user-extras.nix
    ];
  };
}
