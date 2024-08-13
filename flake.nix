{
  description = "My NixOS and home manager configuration";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sway-toolwait = {
      url = "github:rorosen/sway-toolwait";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        nix-darwin.follows = "";
        nuschtosSearch.follows = "";
        devshell.follows = "";
        treefmt-nix.follows = "";
      };
    };
  };

  outputs =
    inputs@{ nixpkgs, sway-toolwait, ... }:
    let
      mkConfig =
        module:
        nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            (_: {
              imports = [ inputs.home-manager.nixosModules.home-manager ];
              nixpkgs.overlays = [ sway-toolwait.overlays.default ];
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
