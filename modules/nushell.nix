{
  den.aspects.ricmaps = {
    nixos =
    { pkgs, ... }:
    {
      environment.shells = with pkgs;[
        nushell
      ];
    };
    
    homeManager =
    { pkgs, config, ...}:
    {
      home.packages = [ pkgs.nu_scripts ];

      programs.nushell = {
        enable = true;
        configFile.text = ''
          use ${pkgs.nu_scripts}/share/nu_scripts/themes/nu-themes/nord.nu
          nord set color_config
        '';
        envFile = {
          text = ''
            $env.config.buffer_editor = "hx"
            $env.config.show_banner = false
          '';
        };
        environmentVariables = config.home.sessionVariables;
      };

      programs.carapace = {
        enable = true;
        enableNushellIntegration = true;
      };
    };
  };
}
