{ pkgs, config, ... }:
{
  home.packages = with pkgs; [
    dust
    hyfetch # hyfetch has a module but it's way better to just configure it interactively
    hyperfine
    ouch
    passage
    tokei
    typos
  ];

  programs.nix-your-shell.enable = true;
  programs.ripgrep.enable = true;
  programs.bottom.enable = true;
  programs.eza = {
    enable = true;
    git = true;
    icons = "auto";
    # need to look into this
    # theme = "";
    # extraOptions = [];
  };

  programs.bat = {
    enable = true;
  };

  programs.zoxide.enable = true;
  programs.fd.enable = true;
  programs.carapace = {
    enable = true;
  };
  programs.starship.enable = true;
  home.shellAliases = {
    nr = "run0 nixos-rebuild switch --flake /etc/nixos";
    nb = "nix build";
    ngc = "run0 nix-collect-garbage --delete-old";
  };

  programs.nushell = {
    enable = true;
    environmentVariables = {
      EDITOR = "hx";
      VISUAL = "hx";
    };
    settings = {
      completions = {
        algorithm = "fuzzy";
      };
      highlight_resolved_externals = true;
      show_banner = false;
      buffer_editor = "hx";
      table = {
        mode = "markdown";
        header_on_separator = true;
        index_mode = "auto";
      };
      filesize.unit = "binary";
      history.file_format = "sqlite";
      rm.always_trash = true;
    };
    extraConfig = ''
      source ${pkgs.nu_scripts}/share/nu_scripts/themes/nu-themes/catppuccin-mocha.nu
    '';
  };
}
