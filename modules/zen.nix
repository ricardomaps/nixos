{ inputs, ... }:
{
  flake-file.inputs = {
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  den.aspects.ricmaps.homeManager = 
  { lib, ... }:
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
                  template = "https://www.youtube.com/results?search_query={searchTerms}";
                  # params = lib.attrsToList { "search_query" = "{searchTerms}"; };
                };
              definedAliases = ["@yt"];
            };

            mynixos = {
              name = "MyNixOS";
              urls = lib.singleton {
                  template = "https://mynixos.com/search";
                  params = lib.attrsToList { "q" = "{searchTerms}"; };
                };
              definedAliases = ["@nx"];
            };

            rustdocs = {
              name = "Docs.rs";
              urls = lib.singleton {
                template = "https://docs.rs/releases/search?query={searchTerms}";
              };
              definedAliases = ["@rs"];
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
  };
}
