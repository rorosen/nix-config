{
  description = "NixOS configuration files";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    temp-linker = {
      url = "github:rorosen/temp-linker";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sway-toolwait = {
      url = "github:rorosen/sway-toolwait";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    home-manager,
    ...
  }: let
    mkConfig = {
      system,
      modules,
    }:
      nixpkgs.lib.nixosSystem {
        inherit system modules;
        specialArgs = {inherit inputs;};
      };
  in {
    homeManagerModules = import ./modules/home-manager;

    nixosConfigurations = {
      hp = mkConfig {
        system = "x86_64-linux";
        modules = [
          ./hosts/hp/configuration.nix
          home-manager.nixosModules.home-manager
        ];
      };

      t14 = mkConfig {
        system = "x86_64-linux";
        modules = [
          ./hosts/t14/configuration.nix
          home-manager.nixosModules.home-manager
        ];
      };

      tower = {
        system = "x86_64-linux";
        modules = [
          ./hosts/tower/configuration.nix
          home-manager.nixosModules.home-manager
        ];
      };
    };
  };
}
