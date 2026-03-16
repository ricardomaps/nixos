{ inputs, ... }:
{
  flake-file.inputs = {
    halloy-theme = {
      url = "github:ricardomaps/halloy-theme.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  den.aspects.ricmaps.homeManager = {
    programs.halloy = {
      enable = true;
      themes = with inputs.halloy-theme.packages.x86_64-linux; {
        inherit Nord;
        inherit "Catppuccin Latte";
      };
      settings = {
        theme = "Nord";
        servers = {
          liberachat = {
            channels = [
              "#halloy"
            ];
            nickname = "ricmaps";
            server = "irc.libera.chat";
          };
          oftc = {
            channels = [
              "#home-manager"
            ];
            server = "irc.oftc.net";
            nickname = "ricmaps";
          };
          ergo = {
            channels = [
              "#derive"
            ];
            server = "irc.ergo.chat";
            nickname = "ricmaps";
          };
        };
      };
    };
  };
}
