 { pkgs, ... }:
{
  # TODO: need to get rid of xdg-utils which helium brings in for this to work
  # imports = [ "${modulesPath}/profiles/perlless.nix" ];
  time.timeZone = "America/Fortaleza";
  i18n.defaultLocale = "en_US.UTF-8";

  networking.hostName = "headful";

  environment.systemPackages = with pkgs; [
    usbutils
    pciutils
    helium-browser
  ];

  # bashless system activation
  system.nixos-init.enable = true;
  # no perl. overlayfs over etc
  system.etc.overlay.enable = true;

  system.stateVersion = "25.05";
}
