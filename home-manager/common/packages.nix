{pkgs, ...}: {
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
    xfce.ristretto
    xfce.tumbler
    libreoffice
    pavucontrol
    flameshot
    gnome.seahorse
    drawio
    gimp
    wireshark

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
    brightnessctl
  ];
}
