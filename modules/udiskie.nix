{
  den.aspects.ricmaps = {
    homeManager = {
      services.udiskie = {
        enable = true;
      };
    };
    nixos = {
      services.udisks2.enable = true;
    };
  };
}
