{
  den.aspects.ricmaps.nixos = {
    users.users.ricmaps.openssh = {
      authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMewo+6MUkWGa3E27ELpMv1QSvdgeq1d8ieNW2Uaj4KD ricmaps@headful"
      ];
    };
    networking.firewall = {
      enable = true;
    };
    services.openssh = {
      enable = true;
      settings = {
        PasswordAuthentication = false;
        KbdInteractiveAuthentication = false;
        PermitRootLogin = "no";
      };
      openFirewall = true;
    };
  };

  den.aspects.ricmaps.homeManager =
  { lib, ... }:
  let
    gitHosts = [
      "github.com"
      "codeberg.org"
      "git.sr.ht"
      "gitlab.com"
      "tangled.org"
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
      matchBlocks = lib.genAttrs gitHosts gitHostConfig;
    };
  };
}
