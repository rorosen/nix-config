{ pkgs, ... }:

{
  # TODO: does not work when using home-manager as a nixos module
  # fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    i3
    polybar
    git
    zsh
    firefox
    evince
    alacritty
    networkmanagerapplet
    cinnamon.nemo
    rofi
    any-nix-shell
    killall
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
    openssh
    arp-scan
    qemu
    virt-manager
    kubectl
    wireguard-tools
    kubernetes-helm
    openssl
    docker
    kubectx
    gparted
    udisks
    sops
    age
    minikube
    pdfsam-basic
    gnome.simple-scan
    pinentry
    gnupg
    texlive.combined.scheme-medium
    xfce.ristretto
    xfce.tumbler
    cargo
    rustc
    rustfmt
    gcc
    gnumake
    element-desktop
    pasystray
    go
    gopls
    libreoffice
    go-outline
    wireshark
    prusa-slicer
    android-tools
    nil
    nixpkgs-fmt
  ];
}

