{
  den.aspects.ricmaps = {
    nixos = {
      programs.zsh.enable = true;
    };

    homeManager = {
      programs.zsh = {
        enable = true;
        enableCompletion = true;
        autosuggestion.enable = true;
        syntaxHighlighting.enable = true;
        autocd = true;
      };
    };
  };
}
