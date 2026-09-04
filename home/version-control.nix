{ pkgs, lib, config, ... }:
{

  programs.gh = {
    enable = true;
    settings = {
      git_protocol = "ssh";
      prefer_editor_prompt = "enabled";
      color_labels = "enabled";
      telemetry = "disabled";
    };
    hosts = {
      "github.com" = {
        user = "ricardomaps";
      };
    };
  };
  
  programs.git = {
    enable = true;
    ignores = [
      ".env"
      ".envrc"
    ];
    signing = {
      signByDefault = true;
      format = "ssh";
      key = "~/.ssh/github.com";
    };
    settings = {
      user = {
        name = "ricmaps";
        email = "ricardomapurungajunior@gmail.com";
      };
      safe.directory = "/etc/nixos";
      init.defaultBranch = "main";
      sendemail = {
        smtpServer = "smtp.gmail.com";
        smtpUser = "ricardomapurungajunior@gmail.com";
        smtpServerPort = "587";
        smtpEncryption = "tls";
      };
      push.autoSetupRemote = true;
    };
  };

}
