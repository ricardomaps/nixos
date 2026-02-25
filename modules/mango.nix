{inputs, ...}:
{
  flake-file.inputs.mango = {
    url = "github:DreamMaoMao/mangowc";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  den.aspects.ricmaps.homeManager =
  {
    imports = [
      inputs.mango.hmModules.mango
    ];

    wayland.windowManager.mango = {
      enable = true;
    };
  };
}
