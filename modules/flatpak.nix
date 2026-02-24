{ inputs, ... }:
{
  den.aspects.headful.nixos = {
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
