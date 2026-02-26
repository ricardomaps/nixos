{
  den.aspects.ricmaps = {
    homeManager =
    { pkgs, ... }:
    {
      i18n.inputMethod = {
        enable = true;
        type = "fcitx5";
        fcitx5 = {
          addons = with pkgs; [
            fcitx5-nord
            fcitx5-table-extra
            fcitx5-table-other
          ];
          waylandFrontend = true;
        };
      };
    };
  };
}

