{ inputs, ... }:
{
  flake-file.inputs.agenix = {
    url = "github:ryantm/agenix";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  den.aspects.ricmaps.homeManager = {
    imports = [ inputs.agenix.homeManagerModules.default ];
    age = {
      identityPaths = ["~/.ssh/id_ed25519"];
      secrets = {
        
      };
    };
  };
}
