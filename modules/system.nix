{ inputs, ... }:
{
  den.aspects.ricmaps.nixos = {
    system.autoUpgrade = {
      enable = true;
      flake = inputs.self.outPath;
      flags = [
        "--print-build-logs"
      ];
      dates = "02:00";
    };

    
  };
}
