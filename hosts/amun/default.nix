{...}: {
  imports = [
    ../common/vps
    ../common/vps/disk.nix
    ../common/vps/openssh.nix
    ./users.nix
  ];

  networking.hostName = "amun";
  boot.loader.grub.devices = ["/dev/sda"];

  system.stateVersion = "23.05";
}
