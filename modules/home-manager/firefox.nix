{ pkgs, ... }:
{
  programs.firefox = {
    enable = true;

    policies = {
      DisableTelemetry = true;
      ExtensionSettings = {
        "uBlock0@raymondhill.net" = {
          installation_mode = "force_installed";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
        };
        "addon@darkreader.org" = {
          installation_mode = "force_installed";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/darkreader/latest.xpi";
        };
      };
    };

    profiles.default = {
      settings = {
        # Always start fresh, no tab restore
        "browser.sessionstore.resume_from_crash" = false;
        "browser.sessionstore.restore_on_demand" = false;
        "browser.sessionstore.max_tabs_undo" = 0;
        "browser.startup.page" = 1; # Blank page
        "browser.newtabpage.enabled" = false;

        # Privacy: Strict settings, no data collection
        "privacy.trackingprotection.enabled" = true;
        "privacy.trackingprotection.socialtracking.enabled" = true;
        "privacy.donottrackheader.enabled" = true;
        "privacy.globalprivacycontrol.enabled" = true;
        "network.cookie.cookieBehavior" = 2; # Block all cookies
        "browser.contentblocking.category" = "strict";

        # Disable autofill and save features
        "browser.formfill.enable" = false;
        "signon.rememberSignons" = false;
        "signon.autofillForms" = false;
        "extensions.formautofill.addresses.enabled" = false;
        "extensions.formautofill.creditCards.enabled" = false;

        # Disable telemetry and data collection
        "toolkit.telemetry.enabled" = false;
        "toolkit.telemetry.unified" = false;
        "toolkit.telemetry.archive.enabled" = false;
        "datareporting.healthreport.uploadEnabled" = false;
        "datareporting.policy.dataSubmissionEnabled" = false;
        "beacon.enabled" = false;
        "browser.ping-centre.telemetry" = false;
        "experiments.enabled" = false;
        "experiments.supported" = false;

        # Remove bloat: Pocket, Firefox Account, etc.
        "extensions.pocket.enabled" = false;
        "identity.fxaccounts.enabled" = false;
        "browser.newtabpage.activity-stream.feeds.section.topstories" = false;
        "browser.newtabpage.activity-stream.feeds.topsites" = false;
        "browser.newtabpage.activity-stream.showSponsored" = false;
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
        "browser.messaging-system.whatsNewPanel.enabled" = false;
        "browser.snippets.enabled" = false;

        # Performance
        "gfx.webrender.all" = true; # Enable WebRender
        "layers.acceleration.enabled" = true;
        "dom.ipc.processCount" = 8; # Adjust based on CPU cores
        "browser.cache.disk.enable" = false; # Disable disk cache
        "browser.cache.memory.enable" = true; # Use memory cache
        "browser.cache.memory.capacity" = 512000; # 512MB memory cache

        # Disable unnecessary features
        "browser.aboutwelcome.enabled" = false;
        "browser.discovery.enabled" = false;
        "browser.onboarding.enabled" = false;
        "browser.vpn_promo.enabled" = false;
        "app.normandy.enabled" = false;
        "app.shield.optoutstudies.enabled" = false;
        "identity.fxaccounts.toolbar.defaultVisible" = false;
        "identity.fxaccounts.toolbar.accessed" = false;
        "identity.fxaccounts.toolbar.enabled" = false;
        "identity.fxaccounts.toolbar.pxiToolbarEnabled" = false;
        "identity.fxaccounts.toolbar.pxiToolbarEnabled.monitorEnabled" = false;
        "identity.fxaccounts.toolbar.pxiToolbarEnabled.relayEnabled" = false;
        "identity.fxaccounts.toolbar.pxiToolbarEnabled.vpnEnabled" = false;
        "identity.fxaccounts.toolbar.syncSetup.enabled" = false;
        "identity.fxaccounts.toolbar.syncSetup.panelAccessed" = false;
        #Ui
        "browser.tabs.inTitlebar" = 0;
        "browser.toolbars.bookmarks.visibility" = "never";
        # "sidebar.revamp" = true;
        # "sidebar.verticalTabs" = true;
        # "browser.engagement.sidebar-button.has-used" = false;
        # "sidebar.expandOnHover" = true;
        # "sidebar.main.tools" = "aichat,history,bookmarks";
      };

      # Search engine: DuckDuckGo only
      search = {
        force = true;
        default = "ddg";
        engines = {
          "ddg" = {
            urls = [ { template = "https://duckduckgo.com/?q={searchTerms}"; } ];
            iconUpdateUrl = "https://duckduckgo.com/favicon.ico";
            updateInterval = 24 * 60 * 60 * 1000; # 24-hour updates
            definedAliases = [ ":ddg" ];
          };
          "Startpage" = {
            urls = [ { template = "https://www.startpage.com/do/search?query={searchTerms}"; } ];
            iconUpdateUrl = "https://www.startpage.com/favicon.ico";
            updateInterval = 24 * 60 * 60 * 1000; # 24-hour updates
            definedAliases = [ ":sp" ];
          };
          "NixOS Packages" = {
            urls = [ { template = "https://search.nixos.org/packages?query={searchTerms}"; } ];
            iconUpdateUrl = "https://nixos.org/favicon.ico";
            updateInterval = 24 * 60 * 60 * 1000; # 24-hour updates
            definedAliases = [ ":n" ];
          };
          "Amazon".metaData.hidden = true;
          "ebay".metaData.hidden = true;
        };
      };
    };
  };
}
