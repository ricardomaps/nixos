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
            qt6Packages.fcitx5-chinese-addons
          ];
          waylandFrontend = true;
        };
      };
    };
    nixos = {
      services.espanso.enable = true;
    };
  };
}

