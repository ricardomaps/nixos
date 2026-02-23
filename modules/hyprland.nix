{
  den.aspects.ricmaps = {
    imports = [
      ./waybar.nix
    ];
    
    programs.hyprshot.enable = false;

    services.swww = {
      enable = false;
    };

    programs.wofi = {
      enable = false;
    };

    wayland.windowManager.hyprland = {
      enable = false;
      settings = {
        monitor = ",preferred,auto,auto";
        exec-once = "waybar & swww-daemon";
        general = {
          gaps_in = 5;
          gaps_out = 20;
          border_size = 2;
          # Set to true enable resizing windows by clicking and dragging on borders and gaps
          resize_on_border = false;
          allow_tearing = false;
          layout = "master";
        };

        decoration = {
          rounding = 4;
          rounding_power = 2;

          # Change transparency of focused and unfocused windows
          active_opacity = 1.0;
          inactive_opacity = 1.0;

          shadow = {
            enabled = true;
            range = 4;
            render_power = 3;
          };

          # https://wiki.hyprland.org/Configuring/Variables/#blur
          blur = {
            enabled = true;
            size = 3;
            passes = 1;

            vibrancy = 0.1696;
          };
        };

        animations = {
            enabled = "yes, please :)";

            # Default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more

            bezier = [
              "easeOutQuint,0.23,1,0.32,1"
              "easeInOutCubic,0.65,0.05,0.36,1"
              "linear,0,0,1,1"
              "almostLinear,0.5,0.5,0.75,1.0"
              "quick,0.15,0,0.1,1"
            ];

            animation = [
              "global, 1, 10, default"
              "border, 1, 5.39, easeOutQuint"
              "windows, 1, 4.79, easeOutQuint"
              "windowsIn, 1, 4.1, easeOutQuint, popin 87%"
              "windowsOut, 1, 1.49, linear, popin 87%"
              "fadeIn, 1, 1.73, almostLinear"
              "fadeOut, 1, 1.46, almostLinear"
              "fade, 1, 3.03, quick"
              "layers, 1, 3.81, easeOutQuint"
              "layersIn, 1, 4, easeOutQuint, fade"
              "layersOut, 1, 1.5, linear, fade"
              "fadeLayersIn, 1, 1.79, almostLinear"
              "fadeLayersOut, 1, 1.39, almostLinear"
              "workspaces, 1, 1.94, almostLinear, fade"
              "workspacesIn, 1, 1.21, almostLinear, fade"
              "workspacesOut, 1, 1.94, almostLinear, fade"
            ];

        };

        dwindle = {
            pseudotile = true; # Master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
            preserve_split = true; # You probably want this
        };

        # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
        master = {
            new_status = "master";
        };

        # https://wiki.hyprland.org/Configuring/Variables/#misc
        misc = {
            force_default_wallpaper = 0; # Set to 0 or 1 to disable the anime mascot wallpapers
            disable_hyprland_logo = true; # If true disables the random hyprland logo / anime girl background. :(
        };

        input = {
            kb_layout = "us,br";
            follow_mouse = 1;
            sensitivity = 0; # -1.0 - 1.0, 0 means no modification.

            touchpad = {
                natural_scroll = false;
            };
        };

        gestures = {
            workspace_swipe = false;
        };

        "$mainMod" = "SUPER";
        "$terminal" = "kitty";
        "$browser" = "librewolf";
        "$menu" = "wofi";

        bind = [

          "$mainMod, Q, exec, $terminal"
          "$mainMod, B, exec, $browser"
          "$mainMod, W, exec, swww img ~/Pictures/Wallpapers"
          "$mainMod, C, killactive,"
          "$mainMod, M, exit,"
          "$mainMod, E, exec, $fileManager"
          "$mainMod, V, togglefloating,"
          "$mainMod, R, exec, $menu --show=drun"
          "$mainMod, P, pseudo," # dwindle
          "$mainMod, T, togglesplit," # dwindle

          "$mainMod, H, movefocus, l"
          "$mainMod, L, movefocus, r"
          "$mainMod, K, movefocus, u"
          "$mainMod, J, movefocus, d"

          "$mainMod, 1, workspace, 1"
          "$mainMod, 2, workspace, 2"
          "$mainMod, 3, workspace, 3"
          "$mainMod, 4, workspace, 4"
          "$mainMod, 5, workspace, 5"
          "$mainMod, 6, workspace, 6"
          "$mainMod, 7, workspace, 7"
          "$mainMod, 8, workspace, 8"
          "$mainMod, 9, workspace, 9"
          "$mainMod, 0, workspace, 10"
          "$mainMod SHIFT, 1, movetoworkspace, 1"
          "$mainMod SHIFT, 2, movetoworkspace, 2"
          "$mainMod SHIFT, 3, movetoworkspace, 3"
          "$mainMod SHIFT, 4, movetoworkspace, 4"
          "$mainMod SHIFT, 5, movetoworkspace, 5"
          "$mainMod SHIFT, 6, movetoworkspace, 6"
          "$mainMod SHIFT, 7, movetoworkspace, 7"
          "$mainMod SHIFT, 8, movetoworkspace, 8"
          "$mainMod SHIFT, 9, movetoworkspace, 9"
          "$mainMod SHIFT, 0, movetoworkspace, 10"
          "$mainMod, S, togglespecialworkspace, magic"
          "$mainMod SHIFT, S, movetoworkspace, special:magic"
          "$mainMod, mouse_down, workspace, e+1"
          "$mainMod, mouse_up, workspace, e-1"

        ];

        # Move/resize windows with mainMod + LMB/RMB and dragging
        bindm = [
          "$mainMod, mouse:272, movewindow"
          "$mainMod, mouse:273, resizewindow"
        ];

        # Laptop multimedia keys for volume and LCD brightness
        bindel = [
          ",XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
          ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
          ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
          ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
          ",XF86MonBrightnessUp, exec, brightnessctl -e4 -n2 set 5%+"
          ",XF86MonBrightnessDown, exec, brightnessctl -e4 -n2 set 5%-"
          "$mainMod SHIFT, l, resizeactive, 20 0"
          "$mainMod SHIFT, h, resizeactive, -20 0"
          "$mainMod SHIFT, k, resizeactive, 0 -20"
          "$mainMod SHIFT, j, resizeactive, 0 20"
        ];

        # Requires playerctl
        bindl = [
          ", XF86AudioNext, exec, playerctl next"
          ", XF86AudioPause, exec, playerctl play-pause"
          ", XF86AudioPlay, exec, playerctl play-pause"
          ", XF86AudioPrev, exec, playerctl previous"
        ];

        windowrule = [
          # Ignore maximize requests from apps. You'll probably like this.
          "suppressevent maximize, class:.*"

          # Fix some dragging issues with XWayland
          "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"

          "size 900 500, title:(Open File)(.*)$"
          "float, title:(Open File)(.*)$"
          "move center, title:(Open File)(.*)$"
        ];
      };
    };
  };
}
