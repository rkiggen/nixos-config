# Browser installations

{ inputs, pkgs, nixpkgs, ... }: {
            
    config = {

       # Tor Browser 
        environment.systemPackages = [
            nixpkgs.from.stable.brave                               # privacy-oriented browser for desktop and laptop computers
            nixpkgs.from.stable.tor-browser                         # privacy-focused browser routing traffic through the Tor network
        #    nixpkgs.from.stable.chromium                            # open source web browser from Google
        ];

        # Firefox: install & configure
        programs.firefox = {
            enable = true;
            package = nixpkgs.from.stable.firefox-esr;
            policies = {
                DisableTelemetry = true;
                DisableFirefoxStudies = true;
                EnableTrackingProtection = {
                    Value = true;
                    Locked = true;
                    Cryptomining = true;
                    Fingerprinting = true;
                };  
                DisablePocket = true;
                DisableFirefoxAccounts = true;
                DisableFirefoxScreenshots = true;
                OverrideFirstRunPage = "";
                OverridePostUpdatePage = "";
                DontCheckDefaultBrowser = true;
                DisplayBookmarksToolbar = "always"; # alternatives: "never" or "newtab"
                DisplayMenuBar = "default-off"; # alternatives: "always", "never" or "default-on"
                SearchBar = "unified"; # alternative: "separate"

                /* ---- EXTENSIONS ---- */
                # Check about:support for extension/add-on ID strings.
                # To add additional extensions, find it on addons.mozilla.org, find
                # the short ID in the url (like https://addons.mozilla.org/en-US/firefox/addon/!SHORT_ID!/)
                # Then, download the XPI by right clicking the "Add to firefox" link
                # unzip the .xpi file, open the manifest.json file and look for [applications|browser_specific_settings].gecko.id
                ExtensionSettings = {
                    "*".installation_mode = "allowed"; # alternatives: "blocked", "force_installed" or "normal_installed"

                    # uBlock Origin
                    "uBlock0@raymondhill.net" = {
                        install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
                        installation_mode = "force_installed";
                    };

                    # Cookie Autodelete
                    "CookieAutoDelete@kennydo.com" = {
                        install_url = "https://addons.mozilla.org/firefox/downloads/latest/cookie-autodelete/latest.xpi";
                        installation_mode = "force_installed";
                    };                   

                    # Multi Account Containers
                    "@testpilot-containers" = {
                        install_url = "https://addons.mozilla.org/firefox/downloads/latest/multi-account-containers/latest.xpi";
                        installation_mode = "force_installed";
                    };

                    # TablissNG
                    "extension@tabliss-maintained" = {
                        install_url = "https://addons.mozilla.org/firefox/downloads/latest/tablissng/latest.xpi";
                        installation_mode = "force_installed";
                    };

                    # Bitwarden 
                    "{446900e4-71c2-419f-a6a7-df9c091e268b}" = {
                        install_url = "https://addons.mozilla.org/firefox/downloads/latest/bitwarden-password-manager/latest.xpi";
                        installation_mode = "force_installed";
                    };
               
                };
            };
        };

        # Firefox: configure policies
        environment.etc."firefox/policies/policies.json".text = builtins.toJSON {
            policies = {
                Preferences = {
                    "gfx.webrender.all" = {
                        Value = false;
                        Status = "locked";
                    };
                    "media.ffmpeg.vaapi.enabled" = {
                        Value = false;
                        Status = "locked";
                    };
                };
            };
        };

        # Chromium : configure
        #programs.chromium = {
        #    enable = true;
        #    # Use ungoogled-chromium or cromite if available in your channel
        #    # package = pkgs.ungoogled-chromium;
        #    homepageLocation = "https://start.duckduckgo.com/";
        #    extensions = [
        #        "ddkjiahejlhfcafbddmgiahcphecmpfh"      # uBlock Origin Lite
        #        "nngceckbapebfimnlniiiahkandclblb"      # Bitwarden / Vaultwarden
        #        "dlaogejjiafeobgofajdlkkhjlignalk"      # TablissNG
        #        "fhcgjolkccmbidfldomjliifgaodjagh"      # Cookie Autodelete
        #    ];
        #    extraOpts = {
        #        #"WebAppInstallForceList" = [
        #        #    {
        #        #        "custom_name" = "Youtube";
        #        #        "create_desktop_shortcut" = false;
        #        #        "default_launch_container" = "window";
        #        #        "url" = "https://youtube.com";
        #        #    }
        #        #];
        #    };
        #};

        # Brave: configure
        environment.etc."brave/policies/managed/policy.json".text = builtins.toJSON {
            # --- Homepage ---
            "HomepageLocation"                          = "https://start.duckduckgo.com/";
            "HomepageIsNewTabPage"                      = false;

            # --- Extensions ---
            "ExtensionInstallForcelist" = [
                "ddkjiahejlhfcafbddmgiahcphecmpfh;https://clients2.google.com/service/update2/crx"  # uBlock Origin Lite
                "nngceckbapebfimnlniiiahkandclblb;https://clients2.google.com/service/update2/crx"  # Bitwarden
                "dlaogejjiafeobgofajdlkkhjlignalk;https://clients2.google.com/service/update2/crx"  # TablissNG
                "fhcgjolkccmbidfldomjliifgaodjagh;https://clients2.google.com/service/update2/crx"  # Cookie Autodelete
                "dhdgffkkebhmkfjojejmpbldmpobfkfo;https://clients2.google.com/service/update2/crx"  # Tampermonkey
            ];

            # --- Telemetry ---
            "MetricsReportingEnabled"                   = false;
            # Disable the invasive enhanced mode, keep standard protection
            "SafeBrowsingEnabled"                       = true;
            "SafeBrowsingExtendedReportingEnabled"      = false;  # never send telemetry
            "SafeBrowsingProtectionLevel"               = 1;  # 0=off, 1=standard, 2=enhanced

            # --- Search & omnibox ---
            "SearchSuggestEnabled"                      = false;
            "UrlKeyedAnonymizedDataCollectionEnabled"   = false;

            # --- Sync & sign-in ---
            "SyncDisabled"                              = true;
            "BrowserSignin"                             = 0;

            # --- Network ---
            "NetworkPredictionOptions"                  = 2;
            "WebRtcIPHandling"                          = "disable_non_proxied_udp";
            "AlternateErrorPagesEnabled"                = false;

             # --- Misc ---
            "TranslateEnabled"                          = false;
            "SpellCheckServiceEnabled"                  = false;
            "AutofillAddressEnabled"                    = false;
            "AutofillCreditCardEnabled"                 = false;
            "PromotionalTabsEnabled"                    = false;
        };

    };
}
