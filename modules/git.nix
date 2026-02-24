{
  den.aspects.ricmaps.homeManager = {
    programs.git = {
      enable = true;
      signing = {
        signByDefault = true;
        format = "ssh";
        key = "~/.ssh/git";
      };
      settings = {
        user.name = "ricmaps"; 
        user.email ="ricardomapurungajunior@gmail.com"; 
        safe.directory = "/etc/nixos";
        init.defaultBranch = "main";
      };
      ignores = [
        ".env"
        ".envrc"
      ];
    };

    programs.difftastic = {
      enable = true;
    };
  
    programs.lazygit = {
      enable = true;
    };
  };
}
