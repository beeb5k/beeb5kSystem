{
  pkgs,
  lib,
  config,
  ...
}: {
  programs.firefox = {
    enable = false;

    policies = {
      DisableTelemetry = true;
      BlockAboutConfig = false;
      DisableFirefoxAccounts = true;
      DisablePocket = true;
      DisableSetDesktopBackground = true;
      DisableSystemAddonUpdate = true;
      AutofillCreditCardEnabled = false;
      AutofillAddressEnabled = false;
      DisableFirefoxScreenshots = true;
      DisableMasterPasswordCreation = true;
      DontCheckDefaultBrowser = true;
      NoDefaultBookmarks = true;
      OfferToSaveLogins = false;
      UserMessaging = {
        WhatsNew = false;
        ExtensionRecommendations = false;
        FeatureRecommendations = false;
        UrlbarInterventions = false;
        SkipOnboarding = true;
        MoreFromMozilla = false;
        Locked = true;
      };
      FirefoxHome = {
        Search = false;
        TopSites = false;
        SponsoredTopSites = false;
        Highlights = false;
        Pocket = false;
        Stories = false;
        SponsoredPocket = false;
        SponsoredStories = false;
        Snippets = false;
        Locked = true;
      };
      FirefoxSuggest = {
        WebSuggestions = false;
        SponsoredSuggestions = false;
        ImproveSuggest = false;
        Locked = true;
      };
      ExtensionSettings =
        {
          "uBlock0@raymondhill.net" = {
            default_area = "menupanel";
            installation_mode = "force_installed";
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
            private_browsing = true;
          };
          # "addon@darkreader.org" = {
          #   installation_mode = "force_installed";
          #   install_url = "https://addons.mozilla.org/firefox/downloads/latest/darkreader/latest.xpi";
          # };
        }
        // lib.optionalAttrs config.hyprland.enable {
          "pywalfox@frewacom.org" = {
            installation_mode = "force_installed";
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/pywalfox/latest.xpi";
          };
        };
    };

    profiles.default = {
      settings = {
        # Always start fresh, no tab restore
        "browser.aboutConfig.showWarning" = false;
        "browser.sessionstore.resume_from_crash" = false;
        "browser.sessionstore.restore_on_demand" = false;
        "browser.sessionstore.max_tabs_undo" = 0;
        "browser.sessionstore.max_windows_undo" = 0;

        # "userChrome.theme-material" = true;

        # "browser.startup.page" = 1; # Blank page
        # "browser.newtabpage.enabled" = false;

        "privacy.trackingprotection.enabled" = true;
        "privacy.trackingprotection.socialtracking.enabled" = true;
        "privacy.globalprivacycontrol.enabled" = true;
        "network.cookie.cookieBehavior" = 2; # Block all cookies
        "browser.contentblocking.category" = "strict";

        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        "svg.context-properties.content.enabled" = true;

        # "beacon.enabled" = false;

        # Performance
        "gfx.webrender.all" = true; # Enable WebRender
        "layers.acceleration.enabled" = true;
        # "dom.ipc.processCount" = 8; # Adjust based on CPU cores
        "browser.cache.disk.enable" = false; # Disable disk cache
        "browser.cache.memory.enable" = true; # Use memory cache
        "browser.cache.memory.capacity" = 1048576; # 1gb memory cache
        "browser.preferences.defaultPerformanceSettings.enabled" = false;
        "media.hardware-video-decoding.force-enabled" = true;
        "media.hardware-video-decoding.enabled" = true;
        "browser.tabs.unloadOnLowMemory" = true;
        "browser.low_commit_space_threshold_percent" = 100;
        "browser.tabs.min_inactive_duration_before_unload" = 3600000;

        # Disable unnecessary features
        "browser.aboutwelcome.enabled" = false;
        "browser.discovery.enabled" = false;
        "browser.onboarding.enabled" = false;

        "browser.tabs.inTitlebar" = 0;
        "browser.toolbars.bookmarks.visibility" = "never";
        "widget.use-xdg-desktop-portal.file-picker" = 1;
      };

      search = {
        force = true;
        default = "ddg";
        engines = {
          duck-duck-go = {
            name = "DuckDuckGo";
            urls = [{template = "https://duckduckgo.com/?q={searchTerms}";}];
            iconMapObj."16" = "https://duckduckgo.com/favicon.ico";
            definedAliases = [":ddg"];
          };
          startpage = {
            name = "Startpage";
            urls = [{template = "https://www.startpage.com/do/search?query={searchTerms}";}];
            iconMapObj."16" = "https://www.startpage.com/favicon.ico";
            definedAliases = [":sp"];
          };
          nixos-packages = {
            name = "NixOS Packages";
            urls = [{template = "https://search.nixos.org/packages?query={searchTerms}";}];
            iconMapObj."16" = "https://nixos.org/favicon.ico";
            definedAliases = [":n"];
          };
          nixos-wiki = {
            name = "NixOS Wiki";
            urls = [{template = "https://wiki.nixos.org/w/index.php?search={searchTerms}";}];
            iconMapObj."16" = "https://wiki.nixos.org/favicon.ico";
            definedAliases = [":nw"];
          };
          amazon.metaData.hidden = true;
          ebay.metaData.hidden = true;
          perplexity.metaData.hidden = true;

          google.metaData.alias = ":g";
          bing.metaData.alias = ":b";
        };
      };
    };
  };
}
