{
  den.aspects.ricmaps.nixos =
  { pkgs, ... }:
  {
    services.displayManager.sddm = {
      enable = true;
      wayland.enable = true;
      extraPackages = [ pkgs.sddm-astronaut ];
      theme = "sddm-astronaut-theme";
    };

    environment.systemPackages = [ pkgs.sddm-astronaut ];
  };
}
