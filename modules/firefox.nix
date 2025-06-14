# Firefox web browser

{ inputs, pkgs, nixpkgs, ... }: {

    config = {

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
                # Then, download the XPI by filling it in to the install_url template, unzip it,
                # run `jq .browser_specific_settings.gecko.id manifest.json` or
                # `jq .applications.gecko.id manifest.json` to get the UUID
                ExtensionSettings = {
                    "*".installation_mode = "allowed"; # alternatives: "blocked", "force_installed" or "normal_installed"

                    # uBlock Origin
                    "uBlock0@raymondhill.net" = {
                        install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
                        installation_mode = "force_installed";
                    };
                };
            };
        };

    };
}
