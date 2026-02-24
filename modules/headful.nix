{
  den.aspects.headful.nixos =
  { pkgs, ... }:
  {
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    boot.kernelPackages = pkgs.linuxPackages_latest;

    networking.hostName = "headful"; # Define your hostname.
    networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.
    time.timeZone = "America/Fortaleza";
    i18n.defaultLocale = "en_US.UTF-8";
    services.printing.enable = false;

    services.power-profiles-daemon.enable = true;
    services.upower.enable = true;

    services.udisks2.enable = true;

    services.displayManager.sddm = {
      enable = true;
      wayland.enable = true;
    };

    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      wireplumber = {
        enable = true;
      };
    };

    services.kanata = {
      package = pkgs.kanata-with-cmd;
      enable = true;
      keyboards = {
        internalKeyboard = {
          devices = [
            "/dev/input/by-path/platform-i8042-serio-0-event-kbd"
          ];
          extraDefCfg = ''
            process-unmapped-keys yes
            danger-enable-cmd yes
          '';
          configFile = ./kanata.kbd;
        };
      };
    };

    xdg.portal = {
      enable = true;
      extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];
    };
    services.flatpak.enable = true;

    hardware.bluetooth.enable = true;
    hardware.bluetooth.powerOnBoot = true;
    hardware.keyboard.qmk.enable = true;
  
    services.blueman.enable = true;

    programs.zsh.enable = true;

    # fonts
    fonts.packages = with pkgs; [
      nerd-fonts.iosevka
      nerd-fonts.jetbrains-mono
      nerd-fonts.fira-mono
      source-code-pro
    ];


    environment.systemPackages = with pkgs; [
      brightnessctl
      pulseaudio
      bibata-cursors
      man-pages
      man-pages-posix
      util-linux
      file
      unzip
      usbutils
    ];

    environment.shells = with pkgs;[
      nushell
    ];

    documentation = {
      dev.enable = true;
      doc.enable = true;
      info.enable = true;
      man.enable = true;
      man.generateCaches = true;
    };

    security.polkit.enable = true;
  };
}
