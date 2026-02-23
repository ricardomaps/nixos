{ den, ... }: {
  den.aspects.ricmaps = {
    includes = [
      den._.primary-user
      (den._.user-shell "zsh")
    ];
  };
}
