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

    programs.zen-browser =  {
      enable = true;
      profiles.ricmaps = rec {
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

            nixpkgs = {
              name = "NixOS Search";
              urls = lib.singleton {
                template = "https://search.nixos.org/packages?channel=unstable&query={searchTerms}";
              };
              definedAliases = ["@np"];
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
        spacesForce = true;
        spaces = {
          "Doom" = {
            id = "c258e389-9a7b-4d75-bfe0-408ab1b92219";
            position = 2000;
          };
          "Research" = {
            id = "44fd5416-49a7-4645-88bf-6776b3319129";
            position = 3000;
          };
        };

        pinsForce = true;
        pins = {
          "ChatGPT" = {
            id = "22b18904-c0c2-4122-9732-e54635c258e0";
            url = "https://chatgpt.com";
            workspace = spaces.Research.id;
          };
          "Claude" = {
            id = "44fd5416-49a7-4645-88bf-6776b3319129";
            url = "https://claude.ai/";
            workspace = spaces.Research.id;
          };
          "Bluesky" = {
            id = "2986bec7-4461-451e-b3b0-5c8df67f1110";
            url = "https://bsky.app/";
            workspace = spaces.Doom.id;
          };
          "Discord" = {
            id = "e8503f35-9e3e-49a3-8a7b-02ecb7e559ed";
            url = "https://discord.com";
            workspace = spaces.Doom.id;
        
          };
          "Reddit" = {
            id = "a35d0a6a-b5a7-4627-a86a-cb520003b889";
            url = "https://reddit.com";
            workspace = spaces.Doom.id;
          
          };
          "Youtube" = {
            id = "d3ac5d6f-9acb-4598-aa35-a7c3debe0836";
            url = "https://youtube.com";
            workspace = spaces.Doom.id;
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
