{modulesPath, ...}: {
  imports = [
    "${modulesPath}/installer/scan/not-detected.nix"
    "${modulesPath}/profiles/qemu-guest.nix"
  ];

  console.keyMap = "de-latin1";
  time.timeZone = "Etc/UTC";
  services.openssh.enable = true;
}
