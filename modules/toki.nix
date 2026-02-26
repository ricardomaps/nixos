{
  den.aspects.ricmaps = {
    homeManager.services.espanso = {
      enable = true;
      x11Support = true;
      waylandSupport = true;
    };

    nixos =
    { pkgs, ... }:
    {
      i18n.inputMethod = {
        enable = true;
        type = "ibus";
        ibus.engines = with pkgs.ibus-engines; [ uniemoji typing-booster table ];
      };
    };
  };
}
