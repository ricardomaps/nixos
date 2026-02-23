{ pkgs, ... }:
{
  den.aspects.dev.homeManager =
  {
    programs.alacritty = {
      enable = true;
      package = pkgs.alacritty.override (_: {
        withGraphics = true;
      });
      theme = "nord";
      settings = {
        shell = {
          program = "zellij";
          args = ["-l" "welcome"];
        };
        font = {
          normal = {
            family = "Fira Mono Nerd Font";
            style = "Regular";
          };
          size = 12;
        };

        mouse = {
          hide_when_typing = true;
        };

        selection = {
          save_to_clipboard = true;
        };

        window = {
          opacity = 0.9;
        };
      };
    };
  };
}
