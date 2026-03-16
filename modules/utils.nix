{
  den.aspects.ricmaps = {
    nixos =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        brightnessctl
        pulseaudio
        util-linux
        file
        unzip
        usbutils
      ];
    };
  };
}
