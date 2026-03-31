{
  den.aspects.ricmaps.homeManager = {
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
  
    programs.hyfetch = {
      enable = true;
      settings = {
        preset = "rainbow";
        mode = "rgb";
        backend = "macchina";
        flag = "trans";
        color_align.mode = "horizontal";
        pride_month_disable = false;
      };
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

    programs.yt-dlp = {
      enable = true;
    };

    programs.zoxide = {
      enable = true;
      enableZshIntegration = true;
      enableNushellIntegration = true;
    };
  };
}
