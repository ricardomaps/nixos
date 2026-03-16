{ den, ... }: {
  den.default = {
    includes = [ den._.define-user ]; # Sets users.users.<name>, home.username, and home.homeDirectory automatically
    nixos.system.stateVersion = "25.05";
    homeManager.home.stateVersion = "25.11";
  };

  den.ctx.hm-host = {
    nixos.home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      backupFileExtension = "backup";
    };
  };

  _module.args.__findFile = den.lib.__findFile;
}
