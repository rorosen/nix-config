{ inputs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../common.nix
  ];

  boot.initrd = {
    systemd.enable = true;
    luks.devices.cryptroot = {
      device = "/dev/disk/by-uuid/cf687882-50a5-48e0-9bca-cb4677de63f1";
      crypttabExtraOpts = [ "fido2-device=auto" ];
    };
  };

  nix = {
    # distributedBuilds = true;
    # buildMachines = [
    #   {
    #     hostName = "aarch64-01";
    #     protocol = "ssh-ng";
    #     systems = [ "aarch64-linux" ];
    #     maxJobs = 40;
    #     speedFactor = 2;
    #     supportedFeatures = [
    #       "nixos-test"
    #       "benchmark"
    #       "big-parallel"
    #       "kvm"
    #     ];
    #   }
    #   {
    #     hostName = "x86-64-01";
    #     protocol = "ssh-ng";
    #     systems = [ "x86_64-linux" ];
    #     maxJobs = 40;
    #     speedFactor = 2;
    #     supportedFeatures = [
    #       "nixos-test"
    #       "benchmark"
    #       "big-parallel"
    #       "kvm"
    #     ];
    #   }
    # ];

    # settings = {
    #   substituters = [ "http://seven-cache01.syseleven.seven.secunet.com/" ];
    #   trusted-public-keys = [ "seven-1:M1znlh60ChXxeuOXaxFVLTrmeJS+UpYVfmI5fmX2Itc=" ];
    #   builders-use-substitutes = true;
    # };
  };

  # programs.ssh.extraConfig = ''
  #   Host aarch64-01
  #     HostName fd00:5ec:0:8008::3
  #     User nixbuild
  #     IdentitiesOnly yes
  #     IdentityFile /path/to/your/private/key
  #   Host x86-64-01
  #     HostName fd00:5ec:0:8008::6
  #     User nixbuild
  #     IdentitiesOnly yes
  #     IdentityFile /path/to/your/private/key
  # '';
  #
  # programs.ssh.knownHosts = {
  #   # aarch64-01
  #   "fd00:5ec:0:8008::3 ssh-ed25519".publicKey = "AAAAC3NzaC1lZDI1NTE5AAAAIH9NXi+pEIjOcsgh6uIcLxyGAP1pnp87E0T8dBj8wahG";
  #   "fd00:5ec:0:8008::3 ssh-rsa".publicKey = "AAAAB3NzaC1yc2EAAAADAQABAAACAQDGRUrwjLpjj7fl8npbpUzQiDyWxb2J4Hh788jKMde6Jjsnu8uttN3Uewsu7Dp72gxhLdsrsVrgDLkZ+Omcyr0bG5gvVEw0NSWL4WLiWzacwlF3hMKTnHsFr0resmcGAM4HvLKdyYKO+gC35+BVW+P7XRDWvpuVmhLEmMLcLWGUf0DAYXmxKuNAU7CjGFlRboidXW+kn1BYoo1Erz2aduRpR/HOcs21oL8+vZMFH/Dx7B8Rnk4gbjm0NutDiyrQrJywT0y+cgacJDSn7eZ+q0gJoToDmwMINLuQxHmza4YqSVyaWtqqiVJyQbq88UCUwo25awy2JDdyhHS2LBMwLYlbxeCDuwpFOK7AvYavK13xoOjPqFNBXACv4byI1WlLcPWYQe5PcQKersDqJ7uD8NRhOfExXk82dGJU/SkV7eznK5K9axHBfgvt255WGdqPCjIc2Ii00SmlqlkEuAz6QJw5dOkeZdEXdissN9jH0r41U6FETrfMipnw+bu5uM30zrfRSnVvHcJvuOWJl+utUctowrqjI5b7LztCgqQgLEWaTb0pf4UZ5XLmC54FAqGVWWPNzlY68KRpAUrvrdtIwpFaaIYf+yu2JeDpSxUOh8XqoZxcMQGVpLElCdpReQktNDxo9JusUYmuTD2Prl3Undf07EkPz7R6bor1FYOq2ojodQ==";
  #   # x86-64-01
  #   "fd00:5ec:0:8008::6 ssh-ed25519".publicKey = "AAAAC3NzaC1lZDI1NTE5AAAAIFZM4vpq5mrih7vS8leIZB1wJok4yVRqVJ30L1euVA45";
  #   "fd00:5ec:0:8008::6 ssh-rsa".publicKey = "AAAAB3NzaC1yc2EAAAADAQABAAABgQDCXgCq63ye8rcQQLIqeo+FeyVMtqP0WuDc6Cn6WAsaH1bF5POtT+dwN6mzs0ysQD25Z17qeeyl/IczNDUzilql42LdlLVbTpmDAgLqHSJp4b/7oLBcAsLxTO5qQjoTQyZ73ShZKGvxWH6QfVFE/NrvTkNKHO8mSYtTD87OzslUXanJ8FfZdmhkfryeGWNRGVUTWLzk2jrw6MkcV1WZdrDRqJMwrA6ztYa0pX9x3/FCjlzGWBHIO3NCuZKjZKOxSaIAxi75+kgHxa+LN39JTNw7A7b1w/tjqMzz38DslniIT0R1Cl3MXwq6pLcIwFSxlzBnQzZyF5wIICMLjq9d7+molCpoVD9ODOc/+r7hB9GBOrDQbXGg2Dop1Ro5BReylpq6sfU1Z4XMYLJ6ijpRpx62pxZgZAC0+RyWkqw3Ejule7gQIfyA799259Dcyjf3rwrrW+jOY6IF9ZEoCWfB+ZA3lQrqsS+9ud42D/8s6yqlM1TUV2bG2D1wOPC1MrtgbDs=";
  # };

  networking = {
    hostName = "t14";
    hosts = {
      "192.168.122.133" = [
        "example.kadem.internal"
        "auth.kadem.internal"
        "dashboard.kadem.internal"
        "registry.kadem.internal"
      ];
      "192.168.100.208" = [ "kadem.herder.syseleven.seven.secunet.com" ];
      # "195.192.158.108" = ["git.seven.secucloud.secunet.com"];
    };
    wg-quick.interfaces.wg0.configFile = "/home/rob/.wireguard/wg0.conf";
  };

  users.users.rob = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "libvirtd"
      "docker"
      "cups"
      "lp"
      "audio"
      "wireshark"
      "video"
      "input"
    ];
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.rob = import ../../rob/t14;
    extraSpecialArgs = {
      inherit inputs;
    };
  };
}
