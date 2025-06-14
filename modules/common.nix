# Common configuration applied to all hosts

{ inputs, pkgs, nixpkgs, userName, hostName, ... }: {

    config = {

        networking = {
            hostName = hostName;
            networkmanager.enable = true;
            enableIPv6 = false;

            hosts = {
                "10.48.6.66" = [ "Canona9afc7.local" "Canona9afc7" ]; # Canon MFC printer
                "10.48.5.2" = [ "BR5CF370C7578A.local" "BR5CF370C7578A" ]; # Brother document scanner
            };
        };

        users.users.${userName} = {
            isNormalUser = true;
            initialPassword = "password"; # change with `passwd`
            shell = pkgs.zsh;
            extraGroups = [ "wheel" "video" "audio" "networkmanager" "lp" "scanner"];
        };

        nixpkgs.config = {
            # Allow proprietary packages.
            allowUnfree = true;
        };

        environment.systemPackages = [
            # bare minimum utils & tools
            ## Flakes clones it dependencies through the git command, 
            ## so it must be installed first
            nixpkgs.from.stable.git	
            nixpkgs.from.stable.delta           # syntax highlighting pager for git
            nixpkgs.from.stable.chezmoi         # manage your dotfiles across multiple machines, securely            
            nixpkgs.from.stable.neovim          # neovim editor
            nixpkgs.from.stable.wget
            nixpkgs.from.stable.pciutils	    # collection of programs for inspecting and manipulating configuration of pci devices
            nixpkgs.from.stable.ntfs3g 	        # ntfs support
            nixpkgs.from.stable.usbutils 	    # tools for working with USB devices
            nixpkgs.from.stable.dmidecode       # a tool that reads information about your system's hardware from the BIOS according to the SMBIOS/DMI standard

        ];

        # Set your time zone.
        time.timeZone = "Europe/Brussels";

        # Select internationalisation properties
        i18n = { 
            defaultLocale = "en_US.UTF-8";
            extraLocaleSettings = {
                LC_TIME = "nl_BE.UTF-8";
                LC_MONETARY = "nl_BE.UTF-8";
            };
        };

        console = {
            font = "Lat2-Terminus16";
            # keyMap = "us";
        };

        # Set the default editor to neovim
        environment.variables = {
            EDITOR = "nvim";
            BROWSER = "firefox-esr";
        };


        # Maximum number of latest generations in the boot menu.
        boot.loader.systemd-boot.configurationLimit = 10;

        nix = {
            # Nix package instance to use throughout the system
            package = pkgs.nixVersions.latest;

            # Additional text appended to `nix.conf`.
            extraOptions = "experimental-features = nix-command flakes";

            settings = {
                # https://nixos.wiki/wiki/Storage_Optimization
                # Optimize nix store during every build. May slow down builds.
                auto-optimise-store = false;
                # experimental-features = [ "nix-command" "flakes"];
            };

            # Garbage collector.
            gc = {
                # Automatically remove unused nix store entries.
                automatic = true;
                dates = "weekly";
                options = "--delete-older-than 7d";
            };
        };
    };
}
