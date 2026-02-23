{inputs, ...}:
{
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
