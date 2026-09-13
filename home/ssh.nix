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
    enableDefaultConfig = false;
    settings =
      lib.genAttrs gitHosts (host:
        {
          User = "git";
          IdentityFile = "~/.ssh/${host}";
          IdentitiesOnly = true;
        }
      ) // {
        "*" = {
          ForwardAgent = false;
          # TODO: revisit this and configure it to use "confirm" with an askpass agent
          AddKeysToAgent = "yes"; 
          Compression = false;
          ServerAliveInterval = 0;
          ServerAliveCountMax = 3;
          HashKnownHosts = false;
          UserKnownHostsFile = "~/.ssh/known_hosts";
          ControlMaster = "no";
          ControlPath = "~/.ssh/master-%r@%n:%p";
          ControlPersist = "no";
        };
      };
  };
}
