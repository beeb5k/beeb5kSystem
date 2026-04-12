{
  inputs,
  pkgs,
  lib,
  ...
}:
let
  extension = shortId: guid: {
    name = guid;
    value = {
      install_url = "https://addons.mozilla.org/en-US/firefox/downloads/latest/${shortId}/latest.xpi";
      installation_mode = "normal_installed";
      private_browsing = true;
      default_area = "menupanel"; # menupanel = unpin, navbar = pin
    };
  };

  prefs = {
    "browser.aboutConfig.showWarning" = false;
    "browser.sessionstore.resume_from_crash" = false;
    "browser.sessionstore.restore_on_demand" = false;
    "browser.sessionstore.restore_tabs_lazily" = false;
    "browser.sessionstore.restore_windows_to_virtual_desktop" = false;
    "browser.sessionstore.max_resumed_crashes" = 0;
    "gfx.webrender.all" = true;
    "gfx.webrender.compositor" = true;
    "gfx.x11-egl.force-enabled" = true;
    "layers.acceleration.force-enabled" = true;
    "media.ffmpeg.vaapi.enabled" = true;
    "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
    "zen.welcome-screen.seen" = true;
  };

  extensions = [
    (extension "ublock-origin" "uBlock0@raymondhill.net")
    (extension "darkreader" "addon@darkreader.org")
  ];
in
{
  home.packages = [
    (pkgs.wrapFirefox
      inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.zen-browser-unwrapped
      {
        extraPrefs = lib.concatLines (
          lib.mapAttrsToList (
            name: value: "lockPref(${lib.strings.toJSON name}, ${lib.strings.toJSON value});"
          ) prefs
        );

        extraPolicies = {
          DisableTelemetry = true;
          AutofillAddressEnabled = true;
          AutofillCreditCardEnabled = false;
          DisableAppUpdate = true;
          DisableFeedbackCommands = true;
          DisableFirefoxStudies = true;
          DisablePocket = true;
          DontCheckDefaultBrowser = true;
          NoDefaultBookmarks = true;
          DisableFirefoxScreenshots = true;
          OfferToSaveLogins = false;
          EnableTrackingProtection = {
            Value = true;
            Locked = true;
            Cryptomining = true;
            Fingerprinting = true;
          };
          DNSOverHTTPS = {
            Enabled = true;
            ProviderURL = "https://dns.quad9.net/dns-query";
            Locked = true;
            Fallback = true;
          };

          ExtensionSettings = builtins.listToAttrs extensions;

          SearchEngines = {
            Default = "DuckDuckGo";
            # Default = "Omnisearch";
            PreventInstalls = true;
            Remove = [
              "Google"
              "Bing"
            ];
            Add = [
              # {
              #   Name = "Omnisearch";
              #   URLTemplate = "http://localhost:8087/search?q={searchTerms}";
              #   IconURL = "http://localhost:8087/static/favicon.ico";
              #   Alias = ":o";
              # }
              {
                Name = "nixpkgs packages";
                URLTemplate = "https://search.nixos.org/packages?query={searchTerms}";
                IconURL = "https://wiki.nixos.org/favicon.ico";
                Alias = ":np";
              }
              {
                Name = "NixOS options";
                URLTemplate = "https://search.nixos.org/options?query={searchTerms}";
                IconURL = "https://wiki.nixos.org/favicon.ico";
                Alias = ":no";
              }
              {
                Name = "NixOS Wiki";
                URLTemplate = "https://wiki.nixos.org/w/index.php?search={searchTerms}";
                IconURL = "https://wiki.nixos.org/favicon.ico";
                Alias = ":nw";
              }
              {
                Name = "noogle";
                URLTemplate = "https://noogle.dev/q?term={searchTerms}";
                IconURL = "https://noogle.dev/favicon.ico";
                Alias = ":ng";
              }
            ];
          };
        };
      }
    )
  ];

  xdg.configFile = {
    "userContent.css" = {
      enable = false;
      text =
        # css
        ''
          img, canvas, video, .avatar, 
          [class*="avatar"], 
          [class*="ProfileAvatar"],
          [style*="border-radius"] {
              border-radius: 0 !important;
              clip-path: none !important;
              mask-image: none !important;
              -webkit-mask-image: none !important;
          }

          /* 2. Reset standard rounding on all elements EXCEPT SVGs */
          :not(svg):not(circle):not(ellipse):not(path) {
              border-radius: 0 !important;
          }

          /* 3. Handle variables that usually affect containers/images */
          :root {
              --border-radius: 0px !important;
              --radius: 0px !important;
              --rounded-corner: 0px !important;
              --avatar-radius: 0px !important;
              --pfp-radius: 0px !important;
          }
        '';
    };
  };

}
