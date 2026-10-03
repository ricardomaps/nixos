{ config, pkgs, ... }:
{
  programs.sway.enable = true;
  programs.sway.extraPackages = [];
  programs.sway.package = pkgs.swayfx;
  
  programs.noctalia = {
    enable = true;
    recommendedServices.enable = true;
  };

  services.displayManager.noctalia-greeter = {
    enable = true;
    settings = {
      cursor = {
        theme = config.home-manager.users.ricmaps.home.pointerCursor.name;
        path = "${config.home-manager.users.ricmaps.home.pointerCursor.package}/share/icons";
        inherit (config.home-manager.users.ricmaps.home.pointerCursor) size;
      };
      keyboard.layout = "us";
    };
  };
  
  # services for a better desktop experience
  services.udisks2.enable = true;
  services.flatpak.enable = true;
  xdg.portal.enable = true;
  services.gnome.gnome-keyring.enable = true;

  environment.pathsToLink = [ "/share/xdg-desktop-portal" "/share/applications" ];
}
