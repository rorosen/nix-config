{
  inputs,
  config,
  lib,
  ...
}: let
  inherit (lib) mkOption types;
  cfg = config.hardware.disk;
in {
  imports = [inputs.disko.nixosModules.disko];

  options.hardware.disk.name = mkOption {
    type = types.str;
    description = "Name of the disk";
  };

  config = {
    boot.loader.grub = {
      devices = [cfg.name];
      efiSupport = true;
      efiInstallAsRemovable = true;
    };

    disko.devices.disk.main = {
      type = "disk";
      device = cfg.name;
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
  };
}
