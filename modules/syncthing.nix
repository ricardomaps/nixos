
{
  den.aspects.ricmaps.homeManager =
  { config, lib, ... }:
  {
    services.syncthing = {
      enable = true;
      overrideDevices = true;
      overrideFolders = true;
      settings =
        let
          syncthingFolder = "${config.home.homeDirectory}/syncthing";
          prefixFolders = lib.mapAttrs' (folder: value: { name = "${syncthingFolder}/${folder}"; inherit value; });
        in
        {
          folders = prefixFolders {
            "images" = {
              id = "nufmf-ald5l";
              devices = ["phone"];
            };
          };

          devices = {
            phone = {
              id = "HWK73AK-GBY7KR4-E3RZPGI-AHEUO5C-XAHCAY5-QPXWY6M-QWQCRJW-UCI5SAZ";
            };
          };

          options = {
            urAccepted = -1;
          };
        };
    };
  };
}
