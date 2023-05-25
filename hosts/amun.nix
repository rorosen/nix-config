{...}: let
  disk = "/dev/sda";
in {
  imports = [
    ./common/server
    ./common/server/disk.nix
  ];

  networking.hostName = "amun";
  hardware.disk.name = disk;

  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIE8BYhhtM7cj2GqBtW3ftPGtlBazkpePGrMSQX4MG2QD rob@hp"
  ];

  system.stateVersion = "23.05";
}
