{ inputs, ... }:
{
  # TODO: using systemd-sysusers and systemd-homed would be the ideal, but it's experimental
  services.userborn.enable = true;

  users = {
    mutableUsers = false;
    users.ricmaps = {
      hashedPasswordFile = "/etc/nixos/password";
      isNormalUser = true;
      extraGroups = [
        "wheel"
        "audio"
        "network"
      ];
    };
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.ricmaps = {
      imports = [
        ../home
      ];
    };
    backupFileExtension = ".backup";
    extraSpecialArgs = { inherit inputs; };
  };
}
