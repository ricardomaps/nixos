{ pkgs, ... }:
{
  security.polkit = {
    enable = true;
    # this is already the default
    # this is basically yet another sudo/run0 like thing, but more stupid in some ways
    enablePkexecWrapper = false;
  };

  # polkit authentication agent
  security.soteria.enable = true;
  
  security.run0 = {
    enable = true;
    persistentAuth.enable = true;
  };

  security.sudo.enable = false;
  security.rtkit.enable = true;

  # suid-less replacement for shadow
  # don't disable the shadow module, it does way more than you think.
  # having mutableUsers = false already makes it so shadow package isn't installed
  # and account-utils module disables whatever other parts of the shadow module become irrelevant
  security.account-utils.enable = true;

  # this is the last suid binary, sadly can't replace it
  # programs.fuse.enable = false;

  security.apparmor = {
    enable = true;
    enableCache = true;
    killUnconfinedConfinables = true;
    packages = [ pkgs.apparmor-profiles ];
  };
}
