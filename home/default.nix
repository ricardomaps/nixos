{
  imports = [
    ./cursor.nix
    ./editor.nix
    ./irc.nix
    ./shell.nix
    ./ssh.nix
    ./sway.nix
    ./tmux.nix
    ./terminal.nix
    ./version-control.nix
    ./xdg.nix
    ./yazi.nix
  ];
  wayland.windowManager.miracle-wm = {
    enable = true;
    settings = {
      startup_apps = [
        { command = "noctalia"; }
      ];
    };
  };
  
  home.stateVersion = "25.11";
}
