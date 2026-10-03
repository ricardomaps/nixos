{ pkgs, ... }:
{
  xdg = {
    enable = true;

    userDirs = {
      enable = true;
      createDirectories = true;
    };

    terminal-exec = {
      enable = true;
      settings = {
        default = [
          "alacritty.desktop"
        ];
      };
    };

    # autostart = {
    #   enable = true;
    #   readOnly = false;
      # entries = [];
    # };
    # mimeApps = {
    #   enable = true;
    # };
    portal.enable = true;
  };
}
