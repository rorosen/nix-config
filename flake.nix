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
        nuschtosSearch.follows = "";
      };
    };
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      nixpkgs,
      sway-toolwait,
      firefox-addons,
      ...
    }:
    let
      mkConfig =
        module:
        nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            (_: {
              imports = [ inputs.home-manager.nixosModules.home-manager ];
              nixpkgs.overlays = [
                sway-toolwait.overlays.default
                (final: _: { firefox-addons = firefox-addons.packages.${final.system}; })
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
      nixosConfigurations = {
        hp = mkConfig ./hosts/hp/configuration.nix;
        t14 = mkConfig ./hosts/t14/configuration.nix;
        tower = mkConfig ./hosts/tower/configuration.nix;
        ibp15 = mkConfig ./hosts/ibp15/configuration.nix;
      };
    };
}
