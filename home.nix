{ pkgs, inputs, ... }:

{
  imports = [
    ./niri.nix
    ./zen.nix
    ./mango.nix
    ./dms.nix
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

  services.udiskie = {
    enable = true;
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
    enableZshIntegration = true;
    settings = {
      theme = "nord";
      pane_frames = false;
    };
    extraConfig = ''
      show_startup_tips false
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
