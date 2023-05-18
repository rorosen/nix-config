# Nix Config

My [NixOS](https://nixos.org/) and [home-manager](https://github.com/nix-community/home-manager) configuration files.

## Adding a Hardware Profile

Place the hardware configuration in the [nixos](./nixos/) directory.
Usually, the hardware configuration is located at `/etc/nixos/hardware-configuration.nix` after a regular installation.
Chose a unique name, e.g. by prepending the hostname.

```shell
cp /etc/nixos/hardware-configuration.nix nixos/<hostname>-hardware-configuration.nix
```

Create a configuration file for the machine at `nixos/<hostname>-configuration.nix`.
Add all device specific configuration and import the formerly copied hardware configuration file.

Consequently, add the profile to [flake.nix](./flake.nix) in `nixosConfigurations`.
Replace `<hostname>` and `<user>` with actual values.
You can add device specific home-manager configuration directly in `sharedModules` or move it to a separate file and import the file.

```nix
<hostname> = nixpkgs.lib.nixosSystem {
  system = "x86_64-linux";
  modules = [
    ./nixos/<hostname>-configuration.nix
    home-manager.nixosModules.home-manager
    {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.users.<user> = import ./home-manager;
      home-manager.sharedModules = [
        ({ ... }: {
          home.username = "<user>";
          home.homeDirectory = "/home/<user>";
          programs.git.userEmail = "you@example.com";
        })
      ];
    }
  ];
};
```

Remember to add newly created files to git before building the profile.

## Sway or i3

Select either Sway or i3 with `windowManager.type` like in `windowManager.type = "sway"`.

## Building a Profile

Just run `sudo nixos-rebuild --flake .#<hostname> switch` from inside the repo.

NB: You can omit the `<hostname>`, if the hostname of your machine matches the name of the configuration.
