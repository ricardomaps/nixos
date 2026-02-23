{
  den.aspects.dev.homeManager = {
    programs.direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };
    
    programs.starship = {
      enable = true;
      enableZshIntegration = true;
      enableNushellIntegration = true;
    };
  
    programs.fastfetch = {
      enable = true;
    };

    programs.tealdeer = {
      enable = true;
    };

    programs.bat = {
      enable = true;
      config = {
        theme = "Nord";
      };
    };

    programs.ripgrep = {
      enable = true;
    };

    programs.fd = {
      enable = true;
    };

    programs.zoxide = {
      enable = true;
      enableZshIntegration = true;
      enableNushellIntegration = true;
    };
  };
}
