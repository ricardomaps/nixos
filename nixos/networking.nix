{
  networking.dhcpcd.enable = false;

  # uses nftables instead of iptables
  networking.nftables.enable = true;

  networking.firewall.enable = true;

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

}
