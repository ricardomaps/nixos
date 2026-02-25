{
  den.aspects.headfult.nixos =
  { pkgs, ... }:
  {
    services.qbittorrent = {
      enable = true;
    };

    environment.systemPackages = [ pkgs.vlc ];
    
  };
}
