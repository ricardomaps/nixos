{ inputs, ... }:
{

  flake-file.inputs.nix-flatpak.url = "github:gmodena/nix-flatpak";
  
  den.aspects.ricmaps.nixos = {
    imports = [ inputs.nix-flatpak.nixosModules.nix-flatpak ];

    services.flatpak = {
      enable = true;
      packages = [
        { appId = "com.stremio.Stremio"; origin = "flathub";  }
      ];
      uninstallUnmanaged = true;
    };
  };
}
