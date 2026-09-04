{ pkgs, ... }:
{
  home.packages = [
    pkgs.wl-clipboard # this is what makes opy to clipboard work
  ];
  
  programs.helix = {
    enable = true;
    package = pkgs.steelix;
    defaultEditor = true;
    extraPackages = [
      pkgs.nixd
      pkgs.nixfmt
      pkgs.steel-language-server
    ];
    settings ={
      theme = "catppuccin_mocha";
      keys = {
        normal = {
          x = "select_line_below";
          X = "select_line_above";
          g = {
            right = "goto_line_end";
            left = "goto_line_start";
          };
        };
        select = {
          g = {
            right = "goto_line_end";
            left = "goto_line_start";
          };
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
          left = [
            "mode"
            "spacer"
            "spinner"
            "file-name"
            "read-only-indicator"
            "file-modification-indicator"
          ];
          right = [
            "diagnostics"
            "version-control"
            "position"            
          ];
        };
        clipboard-provider = "wayland";
        whitespace.render.tab = "all";
        line-number = "relative";
        color-modes = true;
        bufferline = "multiple";
        cursorline = true;
        indent-guides.render = true;
        smart-tab.supersede-menu = true;
        soft-wrap.enable = true;
        lsp.display-inlay-hints = true;
      };
    }; 
  };
}
