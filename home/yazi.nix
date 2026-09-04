{ pkgs, ... }:
{
  programs.yazi = {
    enable = true;
    shellWrapperName = "y";
    plugins = {
      full-border = {
        package = pkgs.yaziPlugins.full-border; 
        setup = true;
      }; 
    };
    settings = {
      mgr = {
        sort_by = "natural";
        sort_sensitive = false;
        sort_dir_first = true;
        show_hidden = true;
        show_symlink = true;
        linemode = "size";
      };
      preview = {
        wrap = "yes";
      };
    };
  };
}
