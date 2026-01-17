{ config, lib, ... }:

{
  options = {
    terminals.kitty.enable = lib.mkEnableOption "enables kitty terminal";
  };

  config = lib.mkIf config.terminals.kitty.enable {
    programs.kitty = {
      enable = true;
      themeFile = "Nord";
      keybindings = {
        "alt+e" = "scroll_line_down";
        "alt+i" = "scroll_line_up";
        "ctrl+u" = "scroll_page_up";
        "ctrl+d" = "scroll_page_down";
      };
      settings = {
        enable_audio_bell = false;
        font_family = "Fira Mono Nerd Font";
        font_size = 12;
        shell_integration = "no-rc";
        dynamic_background_opacity = true;
        allow_remote_control = true;
      };
    };
  };
}
