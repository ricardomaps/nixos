{ pkgs, lib, config, inputs, ... }:

{
  imports = [
    inputs.zen-browser.homeModules.default
  ];

  programs.zen-browser = {
    enable = true;
    profiles.ricmaps = {
      name = "ricmaps";
      extensions = {
        force = true;
        packages = with inputs.firefox-addons.packages."x86_64-linux"; [
          ublock-origin
        ];
      };

      search = {
        force = true;
        default = "ddg";
        engines = {
          youtube = {
            name = "YouTube";
            urls = lib.singleton {
                template = "https://www.youtube.com/results";
                params = lib.attrsToList { "search_query" = "{searchTerms}"; };
              };
            definedAliases = ["@yt"];
          };

          mynixos = {
            name = "MyNixOS";
            urls = lib.singleton {
                template = "https://mynixos.com/search";
                params = lib.attrsToList { "query" = "{searchTerms}"; };
              };
            definedAliases = ["@nx"];
          };
        };
      };
    };

    policies = {
      AutofillAddressEnabled = true;
      AutofillCreditCardEnabled = false;
      DisableAppUpdate = true;
      DisableFeedbackCommands = true;
      DisableFirefoxStudies = true;
      DisablePocket = true;
      DisableTelemetry = true;
      DontCheckDefaultBrowser = true;
      NoDefaultBookmarks = true;
      OfferToSaveLogins = true;
      EnableTrackingProtection = {
        Value = true;
        Locked = true;
        Cryptomining = true;
        Fingerprinting = true;
      }; 
    };
  };
}
