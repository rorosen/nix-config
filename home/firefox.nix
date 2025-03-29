{ lib, pkgs, ... }:
{
  programs.firefox = {
    enable = true;
    profiles.rob = {
      id = 0;
      isDefault = true;
      search = {
        force = true;
        default = "ddg";
        privateDefault = "ddg";
        order = [ "ddg" ];
      };
      bookmarks = {
        force = true;
        settings = [
          {
            name = "General sites";
            toolbar = true;
            bookmarks = [
              {
                name = "GitHub";
                url = "https://github.com/";
              }
              {
                name = "Nix search";
                url = "https://search.nixos.org/packages";
              }
              {
                name = "Nixpkgs Manual";
                url = "https://nixos.org/manual/nixpkgs/unstable/";
              }
              {
                name = "Nixpkgs";
                url = "https://github.com/NixOS/nixpkgs";
              }
            ];
          }
        ];
      };
      extensions.packages = with pkgs.firefox-addons; [
        ublock-origin
        keepassxc-browser
      ];
      settings = {
        "browser.startup.homepage" = "about:home";
        "browser.ctrlTab.sortByRecentlyUsed" = true;

        # Disable irritating first-run stuff
        "browser.disableResetPrompt" = true;
        "browser.download.panel.shown" = true;
        "browser.feeds.showFirstRunUI" = false;
        "browser.messaging-system.whatsNewPanel.enabled" = false;
        "browser.rights.3.shown" = true;
        "browser.shell.checkDefaultBrowser" = false;
        "browser.shell.defaultBrowserCheckCount" = 1;
        "browser.startup.homepage_override.mstone" = "ignore";
        "browser.uitour.enabled" = false;
        "startup.homepage_override_url" = "";
        "trailhead.firstrun.didSeeAboutWelcome" = true;
        "browser.bookmarks.restore_default_bookmarks" = false;
        "browser.bookmarks.addedImportButton" = true;

        # Don't ask for download dir
        "browser.download.useDownloadDir" = false;

        # Disable crappy home activity stream page
        "browser.newtabpage.activity-stream.feeds.topsites" = false;
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
        "browser.newtabpage.activity-stream.improvesearch.topSiteSearchShortcuts" = false;
        "browser.newtabpage.blocked" = lib.genAttrs [
          # Youtube
          "26UbzFJ7qT9/4DhodHKA1Q=="
          # Facebook
          "4gPpjkxgZzXPVtuEoAL9Ig=="
          # Wikipedia
          "eV8/WsSLxHadrTL1gAxhug=="
          # Reddit
          "gLv0ja2RYVgxKdp0I5qwvA=="
          # Amazon
          "K00ILysCaEq8+bEqV/3nuw=="
          # Twitter
          "T9nJot5PurhJSy8n038xGA=="
        ] (_: 1);

        # Disable some telemetry
        "app.shield.optoutstudies.enabled" = false;
        "browser.discovery.enabled" = false;
        "browser.newtabpage.activity-stream.feeds.telemetry" = false;
        "browser.newtabpage.activity-stream.telemetry" = false;
        "browser.ping-centre.telemetry" = false;
        "datareporting.healthreport.service.enabled" = false;
        "datareporting.healthreport.uploadEnabled" = false;
        "datareporting.policy.dataSubmissionEnabled" = false;
        "datareporting.sessions.current.clean" = true;
        "devtools.onboarding.telemetry.logged" = false;
        "toolkit.telemetry.archive.enabled" = false;
        "toolkit.telemetry.bhrPing.enabled" = false;
        "toolkit.telemetry.enabled" = false;
        "toolkit.telemetry.firstShutdownPing.enabled" = false;
        "toolkit.telemetry.hybridContent.enabled" = false;
        "toolkit.telemetry.newProfilePing.enabled" = false;
        "toolkit.telemetry.prompted" = 2;
        "toolkit.telemetry.rejected" = true;
        "toolkit.telemetry.reportingpolicy.firstRun" = false;
        "toolkit.telemetry.server" = "";
        "toolkit.telemetry.shutdownPingSender.enabled" = false;
        "toolkit.telemetry.unified" = false;
        "toolkit.telemetry.unifiedIsOptIn" = false;
        "toolkit.telemetry.updatePing.enabled" = false;
        # Disable fx accounts
        "identity.fxaccounts.enabled" = false;
        # Disable "save password" prompt
        "signon.rememberSignons" = false;
        # Harden
        "privacy.trackingprotection.enabled" = true;
        "dom.security.https_only_mode" = true;
        # Need this for basic search suggestions
        "browser.urlbar.suggest.searches" = true;
        "browser.urlbar.shortcuts.bookmarks" = false;
        "browser.urlbar.shortcuts.history" = false;
        "browser.urlbar.shortcuts.tabs" = false;
        # Make tabs able to be smaller to prevent scrolling
        "browser.tabs.tabMinWidth" = 75;
        "browser.urlbar.placeholderName" = "ddg";
        "browser.urlbar.placeholderName.private" = "ddg";
        # No warning when going to config
        "browser.aboutConfig.showWarning" = false;
        "browser.warnOnQuitShortcut" = false;
        # Load tabs automatically
        "browser.tabs.loadInBackground" = true;
        "browser.toolbars.bookmarks.visibility" = "always";
        # Enable hardware acceleration
        "media.ffmpeg.vaapi.enabled" = true;
        "layers.acceleration.force-enabled" = true;
        "gfx.webrender.all" = true;
        # Use dark mode
        "browser.in-content.dark-mode" = true;
        "ui.systemUsesDarkTheme" = true;
        # Automatically enable extensions
        "extensions.autoDisableScopes" = 0;
        "extensions.update.enabled" = false;
        # Use new gtk file picker instead of legacy one
        "widget.use-xdg-desktop-portal.file-picker" = 1;
      };
    };
  };

  xdg.mimeApps.defaultApplications = {
    "text/html" = [ "firefox.desktop" ];
    "text/xml" = [ "firefox.desktop" ];
    "x-scheme-handler/http" = [ "firefox.desktop" ];
    "x-scheme-handler/https" = [ "firefox.desktop" ];
  };
}
