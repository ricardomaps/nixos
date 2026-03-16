{
  den.aspects.headful.nixos =
  { pkgs, ... }:
  {
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

    hardware.keyboard.qmk.enable = true;
  };
}
