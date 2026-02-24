{
  den.aspects.headful.nixos = {
    nix = {
      gc = {
        automatic = true;
        options = "--delete-older-than 7d";
      };
      optimise.automatic = true;
      settings = {
        auto-optimise-store = true;
        fallback = true;
        connect-timeout = 5;
        experimental-features = [ "nix-command" "flakes" "pipe-operators" ];
      };
    };

    nixpkgs.config.allowUnfree = true;
  };
}
