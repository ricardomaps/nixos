{config, lib, pkgs, inputs, ...}:

let
  noctalia = cmd: [
    "noctalia-shell" "ipc" "call"
  ] ++ (pkgs.lib.splitString " " cmd);
in

{
  imports = [
    ./noctalia.nix
    inputs.niri.homeModules.niri
  ];

  services.mako.enable = true; # notification daemon
  services.swayidle.enable = true; # idle management daemon
  services.polkit-gnome.enable = true; # polkit
  programs.niri.settings = with config.lib.niri.actions; {
    input = {
      keyboard = {
        xkb = {
          layout = "us";
          # variant = "colemak_dh";
          options = "caps:escape";
        };
       numlock = true;
      };

      touchpad = {
        tap = true;
        natural-scroll = true;
      };

      warp-mouse-to-focus.enable = true;
      focus-follows-mouse = {
        enable = true;
        max-scroll-amount = "100%";
      };
    };

    cursor = {
      theme = "Bibata-Original-Ice";
      size = 24;
      hide-after-inactive-ms = 5000;
    };

    # layout {

    #     focus-ring {
    #         active-color   "#8fbcbb"
    #         inactive-color "#2e3440"
    #         urgent-color   "#bf616a"
    #     }

    #     border {
    #         active-color   "#8fbcbb"
    #         inactive-color "#2e3440"
    #         urgent-color   "#bf616a"
    #     }

    #     shadow {
    #         color "#00000070"
    #     }

    #     tab-indicator {
    #         active-color   "#8fbcbb"
    #         inactive-color "#326766"
    #         urgent-color   "#bf616a"
    #     }

    #     insert-hint {
    #         color "#8fbcbb80"
    #     }
    # }

    layout = {
      focus-ring = {
        enable = true;
        active.color   =   "#8fbcbb";
        inactive.color = "#2e3440";
        urgent.color   =   "#bf616a";
      };

      border = {
        enable = true;
        active.color   =   "#8fbcbb";
        inactive.color = "#2e3440";
        urgent.color   =   "#bf616a";
      };

      shadow = {
        color = "#00000070";
      };

      tab-indicator = {
        enable = true;
        active.color   = "#8fbcbb";
        inactive.color = "#326766";
        urgent.color   = "#bf616a";
      };

      insert-hint = {
        enable = true;
        display.color = "#8fbcbb80";
      };

      gaps = 16;
      center-focused-column = "never";
      always-center-single-column = true;
      preset-column-widths = [
        { proportion = 1. / 3.; }
        { proportion = 1. / 2.; }
        { proportion = 2. / 3.; }
      ];
      default-column-width = { proportion = 0.66667; };
      focus-ring = {
        width = 1;
      };
    };

    spawn-at-startup = [
      { argv = ["noctalia-shell"]; }
      { argv = ["kitty"]; }
    ];

    hotkey-overlay = {
      skip-at-startup = true;
    };

    prefer-no-csd = true;

    window-rules = [
      {
        geometry-corner-radius = {
          top-left = 12.;
          top-right = 12.;
          bottom-left = 12.;
          bottom-right = 12.;
        };
        clip-to-geometry = true;
      }

      {
        matches = [
          {
            title = "Firefox";
          }
        ];

        open-maximized = true;
      }

      {
        matches = [
          {
            app-id = "Kitty";
          }
        ];

        opacity = 0.9;
      }
    ];
    
    screenshot-path = "~/Pictures/Screenshots/Screenshot from %Y-%m-%d %H-%M-%S.png";

    binds = {

      "Mod+Space".action.spawn = noctalia "launcher toggle";
      "Mod+Ctrl+W".action.spawn = noctalia "wallpaper toggle";
      "Mod+B".action.spawn = noctalia "bar toggle";
      "Mod+Ctrl+M".action.spawn = noctalia "launcher emoji";
      "Mod+Ctrl+C".action.spawn = noctalia "launcher clipboard";
      "Mod+Ctrl+S".action.spawn = noctalia "sessionMenu toggle";

      "XF86AudioRaiseVolume".action.spawn = noctalia "volume increase";
      "XF86AudioLowerVolume".action.spawn = noctalia "volume decrease";
      "XF86AudioMute".action.spawn = noctalia "volume muteOutput";
      "XF86AudioMicMute".action.spawn = noctalia "volume muteInput";

      "XF86MonBrightnessUp".action.spawn = noctalia "brightness increase";
      "XF86MonBrightnessDown".action.spawn = noctalia "brightness decrease";

      "Mod+P".action = spawn "fuzzel";
      "Mod+T".action = spawn "kitty";

      "Mod+Shift+Y".action = toggle-overview;
      "Mod+Q".action = close-window;

      "Mod+Home".action = focus-column-first;
      "Mod+End".action = focus-column-last;
      "Mod+Ctrl+Home".action = move-column-to-first;
      "Mod+Ctrl+End".action = move-column-to-last;

      "Mod+Page_Down".action = focus-workspace-down;
      "Mod+Page_Up".action = focus-workspace-up;
      "Mod+D".action = focus-workspace-down;
      "Mod+U".action = focus-workspace-up;

      "Mod+Shift+Left".action = focus-monitor-left; 
      "Mod+Shift+Down".action = focus-monitor-down; 
      "Mod+Shift+Up".action = focus-monitor-up; 
      "Mod+Shift+Right".action = focus-monitor-right; 
      "Mod+Shift+N".action = focus-monitor-left; 
      "Mod+Shift+E".action = focus-monitor-down; 
      "Mod+Shift+I".action = focus-monitor-up; 
      "Mod+Shift+O".action = focus-monitor-right; 

      "Mod+Shift+Ctrl+Left".action = move-column-to-monitor-left; 
      "Mod+Shift+Ctrl+Down".action = move-column-to-monitor-down; 
      "Mod+Shift+Ctrl+Up".action = move-column-to-monitor-up; 
      "Mod+Shift+Ctrl+Right".action = move-column-to-monitor-right; 
      "Mod+Shift+Ctrl+N".action = move-column-to-monitor-left; 
      "Mod+Shift+Ctrl+E".action = move-column-to-monitor-down; 
      "Mod+Shift+Ctrl+I".action = move-column-to-monitor-up; 
      "Mod+Shift+Ctrl+O".action = move-column-to-monitor-right; 

      "Mod+Y".action = toggle-overview;

      "Mod+Ctrl+Page_Down".action = move-column-to-workspace-down;
      "Mod+Ctrl+Page_Up".action = move-column-to-workspace-up;
      "Mod+Ctrl+D".action = move-column-to-workspace-down;
      "Mod+Ctrl+U".action = move-column-to-workspace-up;
      # Alternatively, there are commands to move just a single window:
      # Mod+Ctrl+Page_Down { move-window-to-workspace-down; }

      "Mod+Shift+Page_Down".action = move-workspace-down;
      "Mod+Shift+Page_Up".action = move-workspace-up;
      "Mod+1".action = focus-workspace 1;
      "Mod+2".action = focus-workspace 2;
      "Mod+3".action = focus-workspace 3;
      "Mod+4".action = focus-workspace 4;
      "Mod+5".action = focus-workspace 5;
      "Mod+6".action = focus-workspace 6;
      "Mod+7".action = focus-workspace 7;
      "Mod+8".action = focus-workspace 8;
      "Mod+9".action = focus-workspace 9;
      "Mod+Ctrl+1".action.move-column-to-workspace = 1;
      "Mod+Ctrl+2".action.move-column-to-workspace = 2;
      "Mod+Ctrl+3".action.move-column-to-workspace = 3;
      "Mod+Ctrl+4".action.move-column-to-workspace = 4;
      "Mod+Ctrl+5".action.move-column-to-workspace = 5;
      "Mod+Ctrl+6".action.move-column-to-workspace = 6;
      "Mod+Ctrl+7".action.move-column-to-workspace = 7;
      "Mod+Ctrl+8".action.move-column-to-workspace = 8;
      "Mod+Ctrl+9".action.move-column-to-workspace = 9;
 
      "Mod+C".action = center-column;
      # "Mod+Ctrl+C".action = center-visible-columns;
 
      # The following binds move the focused window in and out of a column.
      # If the window is alone, they will consume it into the nearby column to the side.
      # If the window is already in a column, they will expel it out.
      "Mod+BracketLeft".action = consume-or-expel-window-left;
      "Mod+BracketRight".action = consume-or-expel-window-right;
      "Mod+Shift+T".action = toggle-column-tabbed-display;

      # Consume one window from the right to the bottom of the focused column.
      "Mod+Comma".action = consume-window-into-column;
      # Expel the bottom window from the focused column to the right.
      "Mod+Period".action = expel-window-from-column;
 
      "Mod+N".action = focus-column-left;
      "Mod+Left".action = focus-column-left;
      "Mod+O".action = focus-column-right;
      "Mod+Right".action = focus-column-right;
      "Mod+E".action = focus-window-down;
      "Mod+Down".action = focus-window-down;
      "Mod+I".action = focus-window-up;
      "Mod+Up".action = focus-window-up;

      "Mod+R".action = switch-preset-column-width;
      # Cycling through the presets in reverse order is also possible.
      "Mod+Shift+R".action = switch-preset-window-height;
      "Mod+Ctrl+R".action = reset-window-height;
      "Mod+F".action = maximize-column;
      "Mod+Shift+F".action = fullscreen-window;

      # Expand the focused column to space not taken up by other fully visible columns.
      # Makes the column "fill the rest of the space".
      "Mod+Ctrl+F".action = expand-column-to-available-width;

      "Mod+Ctrl+N".action = move-column-left;
      "Mod+Ctrl+Left".action = move-column-left;
      "Mod+Ctrl+O".action = move-column-right;
      "Mod+Ctrl+Right".action = move-column-right;
      "Mod+Ctrl+E".action = move-window-down;
      "Mod+Ctrl+Down".action = move-window-down;
      "Mod+Ctrl+I".action = move-window-up;
      "Mod+Ctrl+Up".action = move-window-up;

      "Mod+Minus".action = set-column-width "-10%";
      "Mod+Equal".action = set-column-width "+10%";
      "Mod+Shift+Minus".action = set-window-height "-10%";
      "Mod+Shift+Equal".action = set-window-height "+10%";
      "Print".action.screenshot = {
        
      };
      "Ctrl+Print".action.screenshot-screen = {
        show-pointer = false;
      };
      "Alt+Print".action.screenshot-window = {
        
      };

      "Mod+Alt+N".action.spawn = ["niri" "msg" "output" "Chimei Innolux Corporation 0x15DB Unknown" "transform" "normal"];
      "Mod+Alt+E".action.spawn = ["niri" "msg" "output" "Chimei Innolux Corporation 0x15DB Unknown" "transform" "90"];
      "Mod+Alt+I".action.spawn = ["niri" "msg" "output" "Chimei Innolux Corporation 0x15DB Unknown" "transform" "180"];
      "Mod+Alt+O".action.spawn = ["niri" "msg" "output" "Chimei Innolux Corporation 0x15DB Unknown" "transform" "270"];

      "Mod+Shift+Delete".action = quit;
    };
  };
}
