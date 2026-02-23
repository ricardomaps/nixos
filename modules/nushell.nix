{
  den.aspects.ricmaps.homeManager =
  { pkgs, ...}:
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
      # environmentVariables = config.home.sessionVariables;
    };

    programs.carapace = {
      enable = true;
      enableNushellIntegration = true;
    };
  };
}
