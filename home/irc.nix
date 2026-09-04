{ pkgs, ... }:
{
  programs.halloy = {
    enable = true;
    settings = {
      theme = "Catppuccin Mocha";
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
        emojis.characters_to_trigger_picker = 1;
        channel.topic_banner = {
          enabled = true;
          max_lines = 2;
        };
        text_input = {
          nickname.enabled = false;
          keybindings = "vim";
          auto_format = "all";
        };
      };

      font = {
        family = "Noto Sans Mono";
        size = 16;
      };

      highlights = {
        match = [
          {
            words = [ "nix" ];
            case_insensitive = true;
          }
        ];
      };

      servers = {
        ergo = {
          server = "irc.ergo.chat";
          channels = [
            "#derive"
            "#9larp"
            "#green"
          ];
          nickname = "ricardomaps";
          alt_nicks = ["ricmaps"];
          realname = "Ricardo Mapurunga Junior";
          sasl.plain = {
            password_command = "passage show irc.ergo.chat";
            username = "ricardomaps";
          };
        };
      };
    };
  };
}
