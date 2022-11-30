# nix-home

[Home Manager](https://nixos.wiki/wiki/Home_Manager) configuration to use on [NixOS](https://nixos.org/).

## Create ISO Image

Create a bootable ISO image containing the configuration directory and flash it to a USB stick.

```bash
nix-build '<nixpkgs/nixos>' -A config.system.build.isoImage -I nixos-config=iso.nix
sudo dd if=result/iso/*.iso of=/dev/<ID> bs=4M status=progress conv=fdatasync
```

## Setup

Follow the NixOS installation as described in the [manual](https://nixos.org/manual/nixos/stable/index.html#ch-installation), stop before executing `nixos-install`.

Copy the content of `/etc/configuration` to `/etc/nixos/`.

```bash
cp /etc/configuration/* /etc/nixos/
```

Move `/etc/nixos/values.nix.example` to `/etc/nixos/values.nix` and set the right values.

Consequently, run `nixos-install`, boot into the new system, log in as root and set a password for the user with `passswd <USERNAME>`.

## Post Install

Link the repo to `/etc/nixos`.

```bash
sudo ln -sf $(pwd)/configuration/* /etc/nixos
```

## Links

- [Home Manager manual](https://nix-community.github.io/home-manager/index.html#sec-install-standalone)
- [Home Manager configuration values](https://nix-community.github.io/home-manager/options.html)
