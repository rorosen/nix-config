{modulesPath, ...}: {
  imports = [
    "${modulesPath}/installer/scan/not-detected.nix"
    "${modulesPath}/profiles/qemu-guest.nix"
  ];

  boot.loader.grub = {
    efiSupport = true;
    efiInstallAsRemovable = true;
  };

  console.keyMap = "de-latin1";
  time.timeZone = "Etc/UTC";
  services.openssh.enable = true;
}
