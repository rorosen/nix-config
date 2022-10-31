{ pkgs, ... }:

{
  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    i3
    polybar
    git
    zsh
    firefox
    vscode
    evince
    alacritty
    networkmanagerapplet
    cinnamon.nemo
    rofi
    any-nix-shell
    killall
    nixpkgs-fmt
    brightnessctl
    spotify
    playerctl
    keepassxc
    nextcloud-client
    freecad
    thunderbird
    betterlockscreen
    shfmt
    signal-desktop
    flameshot

    # fonts
    fantasque-sans-mono
    noto-fonts
    terminus_font
    material-icons
    siji
    (nerdfonts.override { fonts = [ "Meslo" "Iosevka" ]; })
  ];
}

