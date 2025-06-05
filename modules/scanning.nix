# Setup scanning via SANE 
# https://nixos.wiki/wiki/Scanners

{ pkgs, nixpkgs, ... }: {

    config = {

        # Don't forget to add your user to the scanner & lp groups!!!

        # Enables support for SANE scanners
        hardware.sane = {
            enable = true;
            extraBackends = [ nixpkgs.from.stable.brscan5 ];
            brscan5 = {
                enable = true;
                netDevices = {
                    office = { model = "ADS-1700W"; ip = "10.48.5.2"; };
                };
            };
        };

        # Enable saned network daemon for remote connection to scanners
        services.saned = {
            enable = true;
            extraConfig = ''
                10.48.5.0/24
            '';
        };

        services.udev.packages = [ 
            nixpkgs.from.stable.brscan5
        ];

        #services.udev.extraRules = ''
        #    ENV{DEVNAME}!="", ENV{libsane_matched}=="yes", RUN+="${pkgs.acl}/bin/setfacl -m g:scanner:rw $env{DEVNAME}"
        #'';

        nixpkgs.config.permittedInsecurePackages = [
            "dotnet-sdk-6.0.428"
        ];
        
        # Enable wireless scanning via airscan
        environment.systemPackages = [
            ## Backends
            #nixpkgs.from.stable.sane-airscan       # Scanner Access Now Easy - Apple AirScan (eSCL) driver
            nixpkgs.from.stable.brscan5             # Brother brscan5 sane backend driver

            ## Frontends
            nixpkgs.from.stable.simple-scan
            nixpkgs.from.stable.naps2
        ];
    };
}