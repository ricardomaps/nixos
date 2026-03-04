{ inputs, ... }:
{
  flake-file.inputs = {
    swc = {
      url = "path:./packages/swc";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  den.aspects.ricmap.nixos =
  { pkgs, ... }:
  {
    nixpkgs.overlays = [
      (final: prev: {
        swc = inputs.swc.packages."x86_64-linux".default;
      })
    ];

    environment.systemPackages = [ pkgs.swc ];

    security.wrappers.swc-launch = {
      source = "${pkgs.swc}/bin/swc-launch";
      owner = "root";
      group = "root";
      setuid = true;
    };
  };
}
