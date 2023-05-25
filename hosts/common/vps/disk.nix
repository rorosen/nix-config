{
  inputs,
  config,
  ...
}: {
  imports = [inputs.disko.nixosModules.disko];

  disko.devices.disk.main = {
    type = "disk";
    device = builtins.elemAt config.boot.loader.grub.devices 0;
    content = {
      type = "table";
      format = "gpt";
      partitions = [
        {
          name = "boot";
          start = "0";
          end = "1M";
          part-type = "primary";
          flags = ["bios_grub"];
        }
        {
          name = "ESP";
          start = "1MiB";
          end = "100MiB";
          bootable = true;
          content = {
            type = "filesystem";
            format = "vfat";
            mountpoint = "/boot";
          };
        }
        {
          name = "root";
          start = "100MiB";
          end = "100%";
          content = {
            type = "btrfs";
            extraArgs = ["-f"];
            subvolumes = {
              "/rootfs" = {
                mountpoint = "/";
              };
              "/nix" = {
                mountOptions = ["compress=zstd" "noatime"];
              };
            };
          };
        }
      ];
    };
  };
}
