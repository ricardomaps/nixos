{ pkgs, inputs, config, osConfig, lib, ... }:

{
  imports = [
    inputs.nix-index-database.homeModules.default
    ./niri.nix
    ./zen.nix
    ./mango.nix
    ./noctalia.nix
  ];

  home.username = "ricmaps";

  home.homeDirectory = "/home/ricmaps";

  home.packages = with pkgs; [
    starship
    radare2
    inputs.librepods.packages."x86_64-linux".default
    steel
    vial
    nu_scripts
  ];

  home.pointerCursor = {
    enable = true;
    name = "Bibata-Original-Ice";
    package = pkgs.bibata-cursors;
    size = 24;
    x11.enable = true;
    gtk.enable = true;
  };

  programs.nix-index-database.comma.enable = true;
  programs.nix-index = {
    enable = true;
    enableNushellIntegration = true;
  };

  services.udiskie = {
    enable = true;
  };

  services.syncthing = {
    enable = true;
    overrideDevices = true;
    overrideFolders = true;
    settings =
      let
        syncthingFolder = "${config.home.homeDirectory}/syncthing";
        prefixFolders = lib.mapAttrs' (folder: value: { name = "${syncthingFolder}/${folder}"; inherit value; });
      in
      {
        folders = prefixFolders {
          "images" = {
            id = "nufmf-ald5l";
            devices = ["phone"];
          };
        };

        devices = {
          phone = {
            id = "HWK73AK-GBY7KR4-E3RZPGI-AHEUO5C-XAHCAY5-QPXWY6M-QWQCRJW-UCI5SAZ";
          };
        };

        options = {
          urAccepted = -1;
        };
      };
  };
  
  programs.quickshell = {
    enable = true;
  };

  programs.git = {
    enable = true;
    settings = {
      user.name = "ricmaps"; 
      user.email ="ricardomapurungajunior@gmail.com"; 
      safe.directory = "/etc/nixos";
    };
    ignores = [
      ".env"
      ".envrc"
    ];
  };

  programs.jujutsu = {
    enable = true;
  };

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.zellij = {
    enable = true;
    # i don't know how to make this work :(
    # 
    # package = pkgs.zellij.overrideAttrs (prev: {
    #   cargoBuildFlags = (prev.cargoBuildFlags or []) ++ [
    #     "--no-default-features"
    #     "--features" "plugins_from_target,vendored_curl"
    #   ];
    # });
    settings = {
      theme = "nord";
      pane_frames = false;
      show_startup_tips = false;
      default_layout = "disable_status_bar";
    };
    extraConfig = ''
      keybinds {
        shared {
            // Use original Zellij keybinding but with Ctrl+Alt modifier
            // Original: Ctrl+O, now: Ctrl+Alt+O to avoid Helix conflicts
            unbind "Ctrl o"
            bind "Ctrl Alt o" { SwitchToMode "Session"; }

            // Use original Zellij keybinding but with Ctrl+Alt modifier
            // Original: Ctrl+S, now: Ctrl+Alt+S to avoid Helix conflicts
            unbind "Ctrl s"
            bind "Ctrl Alt s" { SwitchToMode "Scroll"; }

            // Previously: Alt + i (in helix: shrink_selection)
            unbind "Alt i"
            // Move tab left (new)
            bind "Alt Shift Left" { MoveTab "Left"; }

            // Previously: Alt + o (in helix: expand_selection)
            unbind "Alt o"
            // Move tab right (new)
            bind "Alt Shift L" { MoveTab "Right"; }

            // Previously: Alt + n (in helix: select_next_sibling)
            bind "Alt m" { NewPane; }
            unbind "Alt n"

            // Previously: Ctrl + b (in helix: move_page_up)
            // Alt+number: Go directly to tab 1-9 (tmux style)
            bind "Alt 1" { GoToTab 1; }
            bind "Alt 2" { GoToTab 2; }
            bind "Alt 3" { GoToTab 3; }
            bind "Alt 4" { GoToTab 4; }
            bind "Alt 5" { GoToTab 5; }
            bind "Alt 6" { GoToTab 6; }
            bind "Alt 7" { GoToTab 7; }
            bind "Alt 8" { GoToTab 8; }
            bind "Alt 9" { GoToTab 9; }

            // Not a remap, just for ease of use
            bind "Alt Shift f" { ToggleFocusFullscreen; SwitchToMode "Normal"; }

            // Alt+q/w: Walk (focus) left/right between tabs
            bind "Alt q" { GoToPreviousTab; }
            bind "Alt w" { GoToNextTab; }

            // Unbind Alt+( and Alt+)
            // fixes selection cycling in helix for alacritty and wezterm
            // does not work for kitty or ghostty
            unbind "Alt ("
            unbind "Alt )"

            // Unbind Alt+p and Alt+Shift+p to avoid conflicts with Helix (select_previous_sibling)
            // Original: Alt+p for TogglePaneInGroup, Alt+Shift+p for ToggleGroupMarking
            // Rebind to Ctrl+Alt+p for pane grouping actions
            unbind "Alt p"
            unbind "Alt Shift p"
            bind "Ctrl Alt p" { TogglePaneInGroup; }
            bind "Ctrl Alt Shift p" { ToggleGroupMarking; }

            // Yazelix command palette (yzx menu) in a floating pane
            bind "Alt Shift m" {
                Run "nu" "~/.config/yazelix/configs/zellij/scripts/yzx_menu_popup.nu" {
                    name "yzx_menu"
                    floating true
                    close_on_exit true
                    x "15%"
                    y "15%"
                    width "70%"
                    height "70%"
                }
            }
        }

        shared_except "pane" "locked" {
            bind "Ctrl p" { SwitchToMode "Pane"; }
        }
  
        shared_except "resize" "locked" {
            bind "Ctrl n" { SwitchToMode "Resize"; }
        }
  
        shared_except "scroll" "locked" {
            unbind "Ctrl s"
            bind "Ctrl Alt s" { SwitchToMode "Scroll"; }
        }
  
        shared_except "session" "locked" {
            unbind "Ctrl o"
            bind "Ctrl Alt o" { SwitchToMode "Session"; }
        }
  
        shared_except "tab" "locked" {
            bind "Ctrl t" { SwitchToMode "Tab"; }
        }
  
        shared_except "move" "locked" {
            bind "Ctrl h" { SwitchToMode "Move"; }
        }
  
        shared_except "locked" {
            unbind "Ctrl b"
        }

        shared_except "locked" {
            bind "Ctrl q" { Quit; }
        }

        pane {
            bind "Ctrl p" { SwitchToMode "Normal"; }
        }

        resize {
            bind "Ctrl n" { SwitchToMode "Normal"; }
        }

        session {
            // Exit session mode
            unbind "Ctrl o"
            bind "Ctrl Alt o" { SwitchToMode "Normal"; }
        }

        scroll {
            // Exit scroll mode
            unbind "Ctrl s"
            bind "Ctrl Alt s" { SwitchToMode "Normal"; }
        }

        tab {
            bind "Ctrl t" { SwitchToMode "Normal"; }
        }

        move {
            bind "Ctrl h" { SwitchToMode "Normal"; }
        }

    }
  '';
  };

  programs.fastfetch = {
    enable = true;
  };

  programs.tealdeer = {
    enable = true;
  };

  programs.bat = {
    enable = true;
    config = {
      theme = "Nord";
    };
  };

  programs.ripgrep = {
    enable = true;
  };

  programs.fd = {
    enable = true;
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
    enableNushellIntegration = true;
  };

  programs.yazi = {
    enable = true;
    flavors = {
      nord = pkgs.yaziPlugins.nord;
    };
    theme = {
      flavor = {
        dark = "nord";
      };
    };
    settings = {
      mgr = {
        show_hidden = true;
        show_symlink = true;
      };
      preview = {
        image_quality = 90;
        image_filter = "lanczos3";
      };
      opener = {
        nu-explore = [
          {
            run = ''
              nu -e "
                def collect-data [...files] {
                  $files
                  | each { |f|
                      let d = open $f
                      match ($d | describe) {
                        "list" => $d
                        _      => [$d]
                      }
                    }
                  | flatten
                  | explore
                }

                collect-data %s"
            '';
            desc = "Open (possibly with merging) file(s) of structured data and view it in nushell's explore pager";
            block = true;
          }
        ];
      };
      open = {
        append_rules = [
          { url = "*.json"; use = "nu-explore"; }
          { url = "*.toml"; use = "nu-explore"; }
          { url = "*.yaml"; use = "nu-explore"; }
        ];
      };
    };
  };

  programs.zathura = {
    enable = true;
  };

  programs.helix = {
    enable = true;
    defaultEditor = true;
    settings = {
      theme = "nord";
      keys = {
        normal = {
          "X" = ["extend_line_up" "extend_to_line_bounds"];
          "g" = {
            "o" = "goto_line_end";
            "n" = "goto_line_start";
          };
        };
      };
      editor = {
        auto-save = true;
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
          left = ["mode" "spacer" "version-control" "read-only-indicator" "file-name" "file-modification-indicator"];
          right = ["diagnostics" "position" "position-percentage"];
        };
        soft-wrap.enable = true;
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

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    autocd = true;
    initContent = ''
      eval "$(starship init zsh)"
    '';
  };

  programs.nushell  = {
    enable = true;
    configFile.text = ''
      use ${pkgs.nu_scripts}/share/nu_scripts/themes/nu-themes/nord.nu
      nord set color_config
    '';
    envFile = {
      text = ''
        $env.config.buffer_editor = "hx"
        $env.config.show_banner = false
      '';
    };
    # environmentVariables = config.home.sessionVariables;
  };

  programs.carapace = {
    enable = true;
    enableNushellIntegration = true;
  };

  programs.alacritty = {
    enable = true;
    package = pkgs.alacritty.override (_: {
      withGraphics = true;
    });
    theme = "nord";
    settings = {
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
      terminal.shell = {
        program = "zellij";
        args = ["-l" "welcome"];
      };
    };
  };

  programs.kitty = {
    enable = false;
    themeFile = "Nord";
    settings = {
      enable_audio_bell = false;
      font_family = "Fira Mono Nerd Font";
      font_size = 12;
      shell_integration = "no-rc";
      dynamic_background_opacity = true;
      allow_remote_control = true;
    };
  };

  programs.wezterm = {
    enable = true;
  };

  # opencode doesn't build at all in my machine
  # programs.opencode = {
  #   enable = true;
  # };
  
  home.stateVersion = "25.11";

  programs.home-manager.enable = true;

  home.enableNixpkgsReleaseCheck = false;
}
