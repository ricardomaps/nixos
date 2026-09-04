{
  pkgs,
  ...
}:
{
  home.packages = [
    pkgs.ueberzugpp
  ];

  xdg.terminal-exec = {
    enable = true;
    settings = {
      default = [
        "alacritty.desktop"
      ];
    };
  };

  programs.alacritty = {
    enable = true;
    theme = "catppuccin_mocha";
    settings = {
      font = {
        normal.family = "JetBrainsMono Nerd Font";
        size = 14;
      };
      mouse.hide_when_typing = true;
      selection.save_to_clipboard = true;
      terminal.shell = "nu";
      keyboard.bindings = [
        {
          action = "ScrollLineUp";
          key = "ArrowUp";
          mods = "Shift";
        }
        {
          action = "ScrollLineDown";
          key = "ArrowDown";
          mods = "Shift";
        }
        {
          action = "CreateNewWindow";
          key = "N";
          mods = "Control|Shift";
        }
      ];
    };
  };
}
