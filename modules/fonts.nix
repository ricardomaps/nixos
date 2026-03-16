{
  den.aspects.ricmaps.nixos =
  { pkgs, ... }:
  {
    fonts = {
      enableDefaultPackages = true;
      packages = with pkgs; [
        nerd-fonts.fira-mono
        nasin-nanpa
      ];
    };
    
  };
}
