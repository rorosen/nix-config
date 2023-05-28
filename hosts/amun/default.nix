{...}: {
  imports = [
    ../common/vps
    ../common/vps/disk.nix
    ../common/vps/openssh.nix
    ./users.nix
  ];

  networking.hostName = "amun";
  boot.loader.grub.devices = ["/dev/sda"];

  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIE8BYhhtM7cj2GqBtW3ftPGtlBazkpePGrMSQX4MG2QD rob@hp"
  ];

  system.stateVersion = "23.05";
}
