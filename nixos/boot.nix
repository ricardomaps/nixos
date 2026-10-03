{ pkgs, ... }:
{

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
}
