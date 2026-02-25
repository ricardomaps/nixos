{ inputs, ...}:
{
  flake-file.inputs.helix = {
    url = "github:helix-editor/helix";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  den.aspects.ricmaps.homeManager =
  { pkgs, ...}:
  {
    programs.helix = {
      enable = true;
      package = inputs.helix.packages.${pkgs.stdenv.hostPlatform.system}.helix;
      defaultEditor = true;
      settings = {
        theme = "nord";
        keys = {
          normal = {
            "x" = "select_line_below";
            "X" = "select_line_above";
            "g" = {
              "right" = "goto_line_end";
              "left" = "goto_line_start";
            };
            "C-g" = [
              ":write-all"
              ":new"
              ":insert-output lazygit"
              ":buffer-close!"
              ":redraw"
              ":reload-all"
            ];
          };

        };
        editor = {
          cursor-shape = {
            normal = "block";
            insert = "bar";
            select = "underline";
          };
          statusline = {
            mode = {
              normal = "NORMAL";
              insert = "INSERT";
              select = "SELECT";
            };
          };
          line-number = "relative";
          color-modes = true;
          bufferline = "multiple";
          cursorline = true;
          indent-guides.render = true;
          smart-tab.supersede-menu = true;
        };
      };

      extraPackages = with pkgs; [
        nixd
        gopls
        marksman
        rust-analyzer
        rustfmt
      ];
    };
  };
}
