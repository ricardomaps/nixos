{ pkgs, inputs, ... }:
{
  environment.defaultPackages = [];
  programs.nano.enable = false;

  time.timeZone = "America/Fortaleza";
  i18n.defaultLocale = "en_US.UTF-8";

  services.printing.enable = false;

  networking.hostName = "headful";

  # hosts file based blocklist
  networking.stevenblack = {
    enable = true;
    block = [
      "social"
      "fakenews"
      "gambling"
      "porn"
    ];
  };
  
  # systemd-resolved set as a dns forwarder to quad9
  services.resolved = {
    enable = true;
    settings.Resolve = {
      DNS = [
        "9.9.9.9#dns.quad9.net"
        "149.112.112.112#dns.quad9.net"
        "2620:fe::9#dns.quad9.net"
        "2620:fe::fe#dns.quad9.net"
      ];
      DNSOverTLS = true;
      # Quad9 already does DNSSEC so this is unnecessary
      # DNSSEC = true;
      # explicitly disallow any others 
      FallbackDNS = [ ];
      # forbids any per-link resolvers
      Domains = ["~."]; 
    };
  };

  # useless
  networking.dhcpcd.enable = false;

  # uses nftables instead of iptables
  networking.nftables.enable = true;

  networking.firewall.enable = true;

  networking.networkmanager = {
    enable = true;
    dns = "systemd-resolved";
    wifi = {
      # better than wpa_supplicant in my case
      backend = "iwd";
      # this is fine as i have good u-apsd and there are no ping issues
      powersave = true;
      # this is the default already but i set it explicitly here bcs opsec level tuff
      scanRandMacAddress = true;
    };
  };

  security.polkit = {
    enable = true;
    # this is already the default, but yeah this is unnecessary and bad
    enablePkexecWrapper = false;
  };

  # polkit authentication agent
  security.soteria.enable = true;
  
  security.run0 = {
    enable = true;
    persistentAuth.enable = true;
  };

  security.sudo.enable = false;

  # suid-less replacement for shadow
  security.account-utils.enable = true;
  security.shadow.enable = false;

  # this is the last suid binary, sadly can't replace it
  # programs.fuse.enable = false;

  # need to learn apparmor first
  security.apparmor = {
    enable = true;
  };

  hardware.enableRedistributableFirmware = true; # enables unfree firmware
  hardware.cpu.intel.updateMicrocode = true;
  
  hardware.bluetooth.enable = true;

  hardware.graphics = {
    enable = true;
    extraPackages = [ pkgs.intel-media-driver ];
    extraPackages32 = with pkgs.pkgsi686Linux; [ intel-media-driver ];
  };

  # the default is fine(["modesetting" "fbdev"]) but i'll remove fbdev anyways
  services.xserver.videoDrivers = [ "modesetting" ];

  services.libinput = {
    enable = true;
    touchpad = {
      naturalScrolling = true;
      tapping = true;
      clickMethod = "clickfinger";
      disableWhileTyping = true;
    };
  };

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true; # this is for stupid wine/proton shit that only works with 32 bit
    pulse.enable = true;
    wireplumber = {
      enable = true;
    };
  };

  users.users.ricmaps = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
    ];
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.ricmaps = {
      imports = [
        ./home
      ];
    };
    backupFileExtension = ".backup";
    extraSpecialArgs = { inherit inputs; };
  };

  boot = {
    plymouth = {
      enable = true;
      theme = "spinfinity";
    };
    # Enable "Silent boot"
    consoleLogLevel = 3;
    initrd.verbose = false;
    kernelParams = [
      "quiet"
      "udev.log_level=3"
      "systemd.show_status=auto"
    ];
    loader.timeout = 0;
    loader.systemd-boot.enable = true;
    # if you don't set this to false you have opsec level fucked
    loader.systemd-boot.editor = false;
    loader.efi.canTouchEfiVariables = true;
    kernelPackages = pkgs.linuxPackages_latest;
  };  

  services.kmscon = {
    enable = true;
    useXkbConfig = true;
    # you can set some cool asciicast options as well
    config = {
      hwaccel = true;
      libseat = true;
      natural-scrolling = true;
    };
  };

  nix = {
    package = pkgs.lixPackageSets.stable.lix;
    gc = {
      automatic = true;
      options = "--delete-older-than 7d";
    };
    channel.enable = false;
    optimise.automatic = true;
    settings = {
      accept-flake-config = false;
      auto-optimise-store = true;
      fallback = true;
      connect-timeout = 5;
      experimental-features = [
        "nix-command"
        "flakes"
        "pipe-operator"
      ];
      # this and the option below seem conflicting,
      # but the option below when empty disables only the global registry
      # and we do want to use _a_ registry, but only our own system registry
      use-registries = true;
      # did you know pridefetch is part of the global registry? retarded
      flake-registry = "";
      trusted-users = [ "ricmaps" ];
      # don't stop building because one derivation failed, very useful
      keep-going = true;
      keep-outputs = false;
      keep-derivations = true;
      log-lines = 40;
      warn-dirty = false;
      # this not being the default is stupid, a testament to how old nix is
      use-xdg-base-directories = true;
      substituters = [
        "https://nix-community.cachix.org"
      ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
    };
  };

  documentation = {
    enable = true;
    man.cache.enable = true; # this makes apropos work
    # mandoc is better than man-db
    man.mandoc.enable = true;
    man.man-db.enable = false;
    # documentation for developers, me developer (supposedly)
    dev.enable = true;
  };

  fonts = {
    # despite being named "default", this is not enabled by default! 
    # enableDefaultPackages = false;
    packages = with pkgs; [
      nerd-fonts.hack
      nerd-fonts.monoid
      nerd-fonts.fira-mono
      nerd-fonts.martian-mono
      nerd-fonts.jetbrains-mono
      noto-fonts
      noto-fonts-color-emoji
    ];
  };

  services.udisks2.enable = true;

  xdg.portal.enable = true;

  services.flatpak.enable = true;

  services.gnome.gnome-keyring.enable = true;

  environment.pathsToLink = [ "/share/xdg-desktop-portal" "/share/applications" ];

  environment.systemPackages = with pkgs; [
    usbutils
    pciutils
    helium-browser
  ];

  programs.noctalia = {
    enable = true;
    recommendedServices.enable = true;
  };

  services.displayManager.noctalia-greeter = {
    enable = true;
    settings = {
      # this should really inherit from the cursor.nix config...
      cursor = {
        theme = "Bibata-Original-Ice";
        path = "${pkgs.bibata-cursors}/share/icons";
        size = 24;
      };
      keyboard.layout = "us";
    };
  };

  system.autoUpgrade = {
    enable = true;
    flake = inputs.self.outPath;
    flags = [
      "--print-build-logs"
    ];
    dates = "02:00";
  };

  system.stateVersion = "25.05";
}
