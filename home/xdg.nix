{ pkgs, ... }:
{
  xdg = {
    enable = true;
    autostart = {
      enable = true;
      readOnly = false;
      # entries = [];
    };
    mimeApps = {
      enable = true;
    };
    portal.enable = true;
  };
}
