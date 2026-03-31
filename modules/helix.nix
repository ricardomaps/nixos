{ inputs, ...}:
{
  flake-file.inputs.helix = {
    url = "github:helix-editor/helix";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  den.aspects.ricmaps.homeManager =
  { pkgs, ...}:
  {
    home.packages = [
      pkgs.wl-clipboard
    ];

    programs.helix = {
      enable = true;
      package = inputs.helix.packages.${pkgs.stdenv.hostPlatform.system}.helix;
      defaultEditor = true;
      themes =
      let
        background = "#080808";
        white = "#eeeeee";
        gray = "#909090";
        darkgray = "#303030";
        black = "#000000";
        cursor = "#555555";
        selected = "#bbbbbb";
        red = "#6F2622";
        green = "#384F2D";
        orange = "#645338";
      in
      {
        grayscale = {
          "string" = "gray";
          "comment" = "gray";
          "keyword" = "gray";
          "keyword.storage.type" = "white";
          "tag" = "gray";

          # ui;
          "ui.background" = {bg=background;};
          "ui.text" = white;
          "ui.text.focus" = {bg=darkgray;};
          "ui.linenr" = {fg=gray;};
          "ui.linenr.selected" = {fg=white;};
          "ui.selection" = {bg=gray; fg=black;};
          "ui.cursorline" = {bg=darkgray;};
          "ui.statusline" = {fg=white; bg=darkgray;};
          "ui.statusline.inactive" = {fg=gray; bg=darkgray;};
          "ui.virtual" = gray;
          "ui.virtual.ruler" = { bg = darkgray ;};
          "ui.cursor" = {bg=cursor; fg=white;};
          "ui.debug" = {fg=orange;};
          "ui.highlight" = {bg=darkgray;};
          "ui.highlight.frameline" = {bg=red;};
          "ui.help" = {fg=white; bg=background;};
          "ui.popup" = {fg=white; bg=background;};
          "ui.menu" = {fg=white; bg=background;};
          "ui.menu.selected" = {fg=black; bg=selected;};
          "ui.window" = {bg=background;};
          "ui.bufferline" = { fg = white; bg = gray ;};
          "ui.bufferline.active" = { fg = white; bg = background ;};

          # error messages;
          "diagnostic.error" = {fg=white; underline={color=red; style="curl";};};
          "diagnostic.warning" = {fg=white; underline={color=orange; style="curl";};};
          "diagnostic.hint" = {fg=gray; modifiers=["bold"];};
          "diagnostic.deprecated" = { modifiers = ["crossed_out"] ;};

          # diff gutter;
          "diff.plus" = {fg = green;};
          "diff.delta" = {fg = orange;};
          "diff.minus" = {fg = red;};

        };
      };
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
          clipboard-provider = "wayland";
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
