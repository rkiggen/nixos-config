# Common configuration applied to all hosts

{ inputs, pkgs, nixpkgs, userName, hostName, ... }: {

    config = {

        networking = {
            hostName = hostName;
            networkmanager.enable = true;
            enableIPv6 = false;
        };

        # Enable CUPS to print documents
        services.printing.enable = true;

        services.avahi = {
            enable = true;
            nssmdns4 = true;
            openFirewall = true;

            # Necessary for detecting the scanner
            publish = {
                enable = true;
                addresses = true;
                userServices = true;
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
            BROWSER = "firefox";
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
