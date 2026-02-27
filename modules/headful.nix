{ inputs, ... }:
{
  den.aspects.headful.nixos =
  { pkgs, lib, ... }:
  {
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    boot.kernelPackages = pkgs.linuxPackages_latest;

    networking.hostName = "headful";
    networking.networkmanager.enable = true;
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

    hardware.bluetooth.enable = true;
    hardware.bluetooth.powerOnBoot = true;
    hardware.keyboard.qmk.enable = true;
  
    services.blueman.enable = true;

    programs.zsh.enable = true;

    # fonts
    fonts = {
      enableDefaultPackages = true;
      packages = with pkgs; [
        nerd-fonts.fira-mono
        nasin-nanpa
      ];
    };

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

    environment.defaultPackages = lib.mkForce [ ];

    environment.shells = with pkgs;[
      nushell
    ];

    system.autoUpgrade = {
      enable = true;
      flake = inputs.self.outPath;
      flags = [
        "--print-build-logs"
      ];
      dates = "02:00";
    };

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
