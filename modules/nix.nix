{ inputs, ... }:
{
  flake-file.inputs = {
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  
  den.aspects.headful.nixos =
  { pkgs, ... }:
  {
    imports = [inputs.nix-index-database.nixosModules.nix-index];

    environment.systemPackages = with pkgs; [
      nix-tree
      nix-nix-inspect
      nix-init
      nix-update
      nurl
      vulnix
      statix
    ];

    programs.nix-index-database.comma.enable = true;
    nix = {
      gc = {
        automatic = true;
        options = "--delete-older-than 7d";
      };
      optimise.automatic = true;
      settings = {
        auto-optimise-store = true;
        fallback = true;
        connect-timeout = 5;
        experimental-features = [ "nix-command" "flakes" "pipe-operators" ];
        trusted-users = [ "ricmaps" ];
      };
    };

    nixpkgs.config.allowUnfree = true;
  };
}
