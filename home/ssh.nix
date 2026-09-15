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
  services.ssh-agent.enable = true;
  
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
