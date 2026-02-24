{
  den.aspects.ricmaps.homeManager =
  { pkgs, ...}:
  {
    programs.yazi = {
      enable = true;
      enableNushellIntegration = true;
      enableZshIntegration = true;
      flavors = {
        nord = pkgs.yaziPlugins.nord;
      };
      plugins = {
        inherit (pkgs.yaziPlugins) chmod smart-enter git sudo;
      };
      theme = {
        flavor = {
          dark = "nord";
        };
      };
      settings = {
        mgr = {
          show_hidden = true;
          show_symlink = true;
        };
        preview = {
          image_quality = 90;
          image_filter = "lanczos3";
        };
        # opener = {
        #   nu-explore = [
        #     {
        #       run = ''
        #         nu -e "
        #           def collect-data [...files] {
        #             $files
        #             | each { |f|
        #                 let d = open $f
        #                 match ($d | describe) {
        #                   "list" => $d
        #                   _      => [$d]
        #                 }
        #               }
        #             | flatten
        #             | explore
        #           }

        #           collect-data %s"
        #       '';
        #       desc = "Open (possibly with merging) file(s) of structured data and view it in nushell's explore pager";
        #       block = true;
        #     }
        #   ];
        # };
        open = {
          append_rules = [
            { url = "*.json"; use = "nu-explore"; }
            { url = "*.toml"; use = "nu-explore"; }
            { url = "*.yaml"; use = "nu-explore"; }
          ];
        };
      };
    };
  };
}
