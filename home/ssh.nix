{ lib, ... }:
let
  gitHosts = [
    "github.com"
    "codeberg.org"
    "git.sr.ht"
    "gitlab.com"
    "tangled.org"
  ];
in
{
  programs.ssh = {
    enable = true;
    settings =
      lib.genAttrs gitHosts (host:
        {
          User = "git";
          IdentityFile = "~/.ssh/${host}";
          IdentitiesOnly = true;
        }
      );
  };
}
