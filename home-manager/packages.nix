{ pkgs, ... }:

{
  # TODO: does not work when using home-manager as a nixos module
  # fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    # gui
    firefox
    ungoogled-chromium
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
    nixpkgs-fmt

    # utils
    git
    killall
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
  ];
}

