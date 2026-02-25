# DO-NOT-EDIT. This file was auto-generated using github:vic/flake-file.
# Use `nix run .#write-flake` to regenerate it.
{
  description = "System configuration";

  outputs = inputs: import ./outputs.nix inputs;

  inputs = {
    den.url = "github:vic/den";
    firefox-addons = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
    };
    flake-aspects.url = "github:vic/flake-aspects";
    flake-file.url = "github:vic/flake-file";
    flake-parts.url = "github:hercules-ci/flake-parts";
    helix = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:helix-editor/helix";
    };
    home-manager = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-community/home-manager";
    };
    import-tree.url = "github:vic/import-tree";
    librepods = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:demenik/librepods";
    };
    mango = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:DreamMaoMao/mangowc";
    };
    niri = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:sodiboo/niri-flake";
    };
    nix-flatpak.url = "github:gmodena/nix-flatpak";
    nix-index-database = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-community/nix-index-database";
    };
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    noctalia-shell = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:noctalia-dev/noctalia-shell";
    };
    zen-browser = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:0xc000022070/zen-browser-flake";
    };
  };

}
