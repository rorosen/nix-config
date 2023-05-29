{
  description = "NixOS configuration files";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    deploy-rs = {
      url = "github:serokell/deploy-rs";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
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
    disko,
    deploy-rs,
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

      amun = mkConfig {
        system = "x86_64-linux";
        modules = [
          ./hosts/amun
        ];
      };
    };

    deploy.nodes = {
      amun = {
        hostname = "";

        profiles.system = {
          sshUser = "rob";
          user = "root";
          sshOpts = ["-A"];
          remoteBuild = true;
          path = deploy-rs.lib.x86_64-linux.activate.nixos self.nixosConfigurations.amun;
        };
      };
    };

    checks = builtins.mapAttrs (system: deployLib: deployLib.deployChecks self.deploy) deploy-rs.lib;
  };
}
