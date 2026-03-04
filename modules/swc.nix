{
  den.aspects.ricmap.nixos =
  { pkgs, ... }:
  {
    nixpkgs.overlays = [
      (final: prev: {
        wld = final.callPackage ../packages/wld/default.nix {};
        swc = final.callPackage ../packages/swc/default.nix {};
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
