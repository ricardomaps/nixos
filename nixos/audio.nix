{
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true; # this is for stupid wine/proton shit that only works with 32 bit
    pulse.enable = true;
    jack.enable = true;
    wireplumber = {
      enable = true;
    };
  };  
}
