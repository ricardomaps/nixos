{
  description = "System configuration";

  inputs = {
    # nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixpkgs.url = "github:ricardomaps/nixpkgs?ref=update-miracle";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # home-manager = {
    #   url = "github:ricardomaps/home-manager?ref=add-miracle-wm";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
    helium = {
      url = "github:amaanq/helium-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
  { nixpkgs, ... }@inputs:
  {
    nixosConfigurations.headful = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [
        ./hardware-configuration.nix
        ./config.nix
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
