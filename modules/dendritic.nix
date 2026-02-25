{ inputs, ... }:
{
  imports = [
    inputs.den.flakeModules.default
    inputs.flake-file.flakeModules.default
  ];

  flake-file = {
    description = "System configuration";
    inputs = {
      nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

      nix-flatpak.url = "github:gmodena/nix-flatpak";

      nix-index-database = {
        url = "github:nix-community/nix-index-database";
        inputs.nixpkgs.follows = "nixpkgs";
      };

      niri = {
        url = "github:sodiboo/niri-flake";
        inputs.nixpkgs.follows = "nixpkgs";
      };

      mango = {
        url = "github:DreamMaoMao/mangowc";
        inputs.nixpkgs.follows = "nixpkgs";
      };
    
      noctalia-shell = {
        url = "github:noctalia-dev/noctalia-shell";
        inputs.nixpkgs.follows = "nixpkgs";
      };

      helix = {
        url = "github:helix-editor/helix";
        inputs.nixpkgs.follows = "nixpkgs";
      };

      librepods = {
        url = "github:demenik/librepods";
        inputs.nixpkgs.follows = "nixpkgs";
      };

      zen-browser = {
        url = "github:0xc000022070/zen-browser-flake";
        inputs.nixpkgs.follows = "nixpkgs";
      };

      firefox-addons = {
        url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
        inputs.nixpkgs.follows = "nixpkgs";
      };

      home-manager = {
        url = "github:nix-community/home-manager";
        inputs.nixpkgs.follows = "nixpkgs";
      };

      den.url = "github:vic/den";
      flake-aspects.url = "github:vic/flake-aspects";
      import-tree.url = "github:vic/import-tree";
      flake-parts.url = "github:hercules-ci/flake-parts";
      flake-file.url = "github:vic/flake-file";
    };
  };
}
