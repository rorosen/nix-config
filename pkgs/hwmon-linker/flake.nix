{
  description = "Linker for HWMON temp inputs";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";

    crane = {
      url = "github:ipetkov/crane";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, crane, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        craneLib = crane.lib.${system};

        src = craneLib.cleanCargoSource (craneLib.path ./.);
        commonArgs = {
          inherit src;

          pname = "hwmon-linker";
          version = "1.0.0";
        };
        cargoArtifacts = craneLib.buildDepsOnly commonArgs;

        hwmon-linker = craneLib.buildPackage (commonArgs // {
          inherit cargoArtifacts;
        });
      in
      {
        packages.default = hwmon-linker;
      });
}
