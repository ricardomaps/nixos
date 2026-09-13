{
  pkgs,
  ...
}:
{
  programs.tmux = {
    enable = true;
    shell = "${pkgs.nushell}/bin/nu";
    clock24 = true;
    mouse = true;
    terminal = "tmux-256color";
    disableConfirmationPrompt = true;
  };
}
