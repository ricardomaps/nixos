{
  den.hosts.x86_64-linux.headful = {
    users.ricmaps = {
      classes = [ "homeManager" ];
    };
  };

  den.aspects.headful.nixos =
  { pkgs, lib, ... }:
  {
    environment.defaultPackages = lib.mkForce [ ];
  };
}
