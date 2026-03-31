{ inputs, ... }:
{
  flake-file.inputs = {
    halloy-theme = {
      url = "github:ricardomaps/halloy-theme.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  den.aspects.ricmaps.homeManager = {
    programs.halloy = {
      enable = true;
      themes = with inputs.halloy-theme.packages.x86_64-linux; {
        inherit Nord;
        inherit "Catppuccin Latte";
      };
      settings = {
        theme = "Nord";
        actions.buffer = {
          click_channel_name = "replace-pane";
          click_highlight = "new-pane";
          click_username = "new-pane";
          join_channel = "replace-pane";
          message_channel = "replace-pane";
          message_user = "new-pane";
          local = "replace-pane";
        };
        actions.sidebar = {
          buffer = "replace-pane";
        };
        buffer = {
          server_messages.topic.enabled = false;
          channel.topic_banner = {
            enabled = true;
            max_lines = 2;
          }
          text_input = "all"; # allows to use markdown and token based formatting
        }
        font = {
          family = "Fira Mono Nerd Font";
          size = "16";
        }
        highlights = {
          match = [
            {
              words = ["neu-nix" "nix"];
              case_insensitive = true;
              exclude = "all";
              include = { channels = ["#derive"]; };
            }
          ];
        };
        servers = {
          liberachat = {
            channels = [
              "#halloy"
              "#river"
            ];
            nickname = "ricardomaps";
            alt_nicks = ["ricmaps"];
            realname = "Ricardo Mapurunga Junior"
            server = "irc.libera.chat";
          };
          oftc = {
            channels = [
              "#home-manager"
            ];
            server = "irc.oftc.net";
            nickname = "ricardomaps";
            alt_nicks = ["ricmaps"];
            realname = "Ricardo Mapurunga Junior"
          };
          ergo = {
            channels = [
              "#derive"
            ];
            server = "irc.ergo.chat";
            nickname = "ricardomaps";
            alt_nicks = ["ricmaps"];
            realname = "Ricardo Mapurunga Junior"
          };
        };
      };
    };
  };
}
