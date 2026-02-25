{
  den.aspects.headful.nixos =
  { pkgs, ... }:
  {
    services.qbittorrent = {
      enable = true;
    };

    environment.systemPackages = [ pkgs.vlc ];
    
  };
}
