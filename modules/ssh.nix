{
  den.aspects.ricmaps.homeManager =
  { lib, ... }:
  let
    gitHosts = [
      "github.com"
      "codeberg.org"
      "sr.ht"
    ];
    gitHostConfig = host: {
      user = "git";
      identityFile = "~/.ssh/${host}";
      identitiesOnly = true;
    };
  in
  {
    programs.ssh = {
      enable = true;
      matchBlocks = lib.genAttrs gitHosts gitHostConfig // {
        "pwn.college" = {
          user = "hacker";
          identityFile = "~/.ssh/pwn";
          identitiesOnly = true;
        };
      };
    };
  };
}
