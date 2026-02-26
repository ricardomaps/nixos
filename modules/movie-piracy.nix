{
  den.aspects.headful.nixos =
  { pkgs, ... }:
  {
    services.qbittorrent = {
      enable = true;
      serverConfig = {
        LegalNotice.Accepted = true;
        Preferences = {
          WebUI = {
            LocalHostAuth = true;
            Username = "ricmaps";
            Password_PBKDF2 = "@ByteArray(ARQ77eY1NUZaQsuDHbIMCA==:0WMRkYTUWVT9wVvdDtHAjU9b3b7uB8NR1Gur2hmQCvCDpm39Q+PsJRJPaCU51dEiz+dTzh8qbPsL8WkFljQYFQ==)";
          };
          General.Locale = "en";
        };
      };
    };

    environment.systemPackages = with pkgs; [ vlc ];
    
  };
}
