let
  sources = import ./sources.nix { };
  pkgs = import sources.nixpkgs {
    overlays = [ (import sources.rust-overlay) ];
  };

  crane = pkgs.callPackage sources.crane { };
  rustToolchain = pkgs.rust-bin.fromRustupToolchainFile ../rust-toolchain.toml;
  craneLib = crane.overrideToolchain rustToolchain;

  hwmonLinker = pkgs.callPackage ./build.nix { inherit craneLib; };
in
{
  inherit (hwmonLinker) hwmon-linker;
}
