{
  den.aspects.ricmaps.homeManager =
  { pkgs, ... }:
  {
    xdg = {
      enable = true;
      userDirs.createDirectories = true;
      autostart = {
        enable = true;
        readOnly = true;
      };
      portal = {
        enable = true;
        extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];
      };

    };
  };
}
