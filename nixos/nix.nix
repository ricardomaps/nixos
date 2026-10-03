{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    nix-diff
    nix-tree
    nix-init
    cachix
  ];
  
  nix = {
    package = pkgs.lixPackageSets.stable.lix;
    gc = {
      automatic = true;
      options = "--delete-older-than 7d";
    };
    channel.enable = false;
    optimise.automatic = true;
    settings = {
      accept-flake-config = false;
      auto-optimise-store = true;
      fallback = true;
      connect-timeout = 5;
      experimental-features = [
        "nix-command"
        "flakes"
        "pipe-operator"
      ];
      # this and the option below seem conflicting,
      # but the option below when empty disables only the global registry
      # and we do want to use _a_ registry, but only our own system registry
      use-registries = true;
      # did you know pridefetch is part of the global registry? retarded
      flake-registry = "";
      trusted-users = [ "ricmaps" ];
      # don't stop building because one derivation failed, very useful
      keep-going = true;
      keep-outputs = true;
      keep-derivations = true;
      log-lines = 40;
      warn-dirty = false;
      # this not being the default is stupid, a testament to how old nix is
      use-xdg-base-directories = true;
      substituters = [
        "https://nix-community.cachix.org"
        "https://ricardomaps.cachix.org"
      ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "ricardomaps.cachix.org-1:AVvxxC1GomUHR6bxXYgkh/XsIr/yUbg8B/tKpN70Opw="
      ];
    };
  };
 
}
