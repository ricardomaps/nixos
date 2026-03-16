{
  den.aspects.ricmaps.homeManager = {
    programs.zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      autocd = true;
      initContent = ''
        eval "$(starship init zsh)"
      '';
    };
  };
}
