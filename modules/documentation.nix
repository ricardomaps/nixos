{
  den.aspects.ricmaps.nixos =
  { pkgs, ... }:
  {
    documentation = {
      dev.enable = true;
      doc.enable = true;
      info.enable = true;
      man.enable = true;
      man.cache.enable = true;
    };

    environment.systemPackages = with pkgs; [
      man-pages
      man-pages-posix
    ];
  };
}
