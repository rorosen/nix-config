{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # gui
    firefox
    evince
    cinnamon.nemo
    keepassxc
    spotify
    virt-manager
    gparted
    pdfsam-basic
    gnome.simple-scan
    xfce.ristretto
    xfce.tumbler
    libreoffice
    pavucontrol
    pasystray
    flameshot
    gnome.seahorse
    drawio

    # terminal
    zsh
    alacritty
    any-nix-shell

    # programming
    shfmt
    cargo
    rustc
    rustfmt
    gcc
    gnumake
    go
    gopls
    go-outline
    nil
    alejandra

    # utils
    git
    openssh
    arp-scan
    qemu
    kubectl
    wireguard-tools
    kubernetes-helm
    openssl
    kubectx
    sops
    age
    minikube
    udisks
    pinentry
    gnupg
    texlive.combined.scheme-medium
    wireshark
    brightnessctl
  ];
}

