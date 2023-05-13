{ craneLib }:

let
  src = craneLib.cleanCargoSource (craneLib.path ./..);

  commonArgs = {
    inherit src;

    pname = "hwmon-linker";
    version = "0.0.1";
  };

  cargoArtifacts = craneLib.buildDepsOnly commonArgs;

  hwmonLinkerCrate = craneLib.buildPackage (commonArgs // {
    inherit cargoArtifacts;
  });
in
{
  hwmon-linker = hwmonLinkerCrate;
}
