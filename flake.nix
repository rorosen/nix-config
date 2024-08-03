{
  description = "NixOS configuration files";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    temp-linker = {
      url = "/home/rob/misc/temp-linker";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sway-toolwait = {
      url = "github:rorosen/sway-toolwait";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      nixpkgs,
      temp-linker,
      sway-toolwait,
      ...
    }:
    let
      mkConfig =
        module:
        nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            (_: {
              nixpkgs.overlays = [
                temp-linker.overlays.default
                sway-toolwait.overlays.default
              ];
            })
            module
          ];
          specialArgs = {
            inherit inputs;
          };
        };
    in
    {
      homeManagerModules = import ./modules/home-manager;
      nixosConfigurations = {
        hp = mkConfig ./hosts/hp/configuration.nix;
        t14 = mkConfig ./hosts/t14/configuration.nix;
        tower = mkConfig ./hosts/tower/configuration.nix;
      };
    };
}
