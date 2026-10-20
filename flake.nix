{
  description = "System configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixos-hardware = {
      url = "github:soopyc/nixos-hardware?ref=apple-t2-updates";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    helium = {
      url = "github:amaanq/helium-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
  { nixpkgs, ... }@inputs:
  {
    nixosConfigurations.t2 = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [
        # add t2 hardware module
        inputs.nixos-hardware.nixosModules.apple-t2
        ./nixos
        inputs.home-manager.nixosModules.default
        {
          nixpkgs.overlays = [
            (final: prev: {
              helium-browser = inputs.helium.packages.x86_64-linux.default;
            })
          ];
        }
      ];
    };
    nixosConfigurations.headful = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [
        ./hardware-configuration.nix
        ./nixos
        inputs.home-manager.nixosModules.default
        {
          nixpkgs.overlays = [
            (final: prev: {
              helium-browser = inputs.helium.packages.x86_64-linux.default;
            })
          ];
        }
      ];
    };
  }
  
  ;

}
