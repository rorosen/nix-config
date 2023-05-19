{
  description = "NixOS configuration files";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    temp-linker = {
      url = "github:rorosen/temp-linker/";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    nixpkgs,
    home-manager,
    ...
  }: let
    homeManagerModules = import ./modules/home-manager;
  in {
    nixosConfigurations = {
      hp = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./nixos/hp-configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.rob = import ./home-manager;
              extraSpecialArgs = {inherit inputs homeManagerModules;};
              sharedModules = [
                ./home-manager/hp-home.nix
              ];
            };
          }
        ];
      };
      t14 = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./nixos/t14-configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.rob = import ./home-manager;
              extraSpecialArgs = {inherit inputs homeManagerModules;};
              sharedModules = [
                ./home-manager/t14-home.nix
              ];
            };
          }
        ];
      };
    };
  };
}
