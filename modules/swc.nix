{ inputs, ... }:
{
  flake-file.inputs = {
    neu-nix = {
      url = "github:ricardomaps/neu-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  den.aspects.ricmaps.nixos =
  { pkgs, ... }:
  {
    nixpkgs.overlays = [
      inputs.neu-nix.overlays.default
    ]
    ;
    environment.systemPackages = with pkgs; [
      shko
      hevel
      neumenu
      hack
      swall
      swiv
      swclock
      mojito
    ];
  };
}
