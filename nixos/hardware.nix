{ pkgs, ... }:
{
  hardware.enableRedistributableFirmware = true; # enables unfree firmware
  hardware.cpu.intel.updateMicrocode = true;
  hardware.bluetooth.enable = true;

  hardware.graphics = {
    enable = true;
    extraPackages = [ pkgs.intel-media-driver ];
    extraPackages32 = with pkgs.pkgsi686Linux; [ intel-media-driver ];
  };
}
