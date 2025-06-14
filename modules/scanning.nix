# Setup scanning via SANE 
# https://nixos.wiki/wiki/Scanners

{ pkgs, nixpkgs, ... }: {

    config = {

        # Don't forget to add your user to the scanner & lp groups!!!

        # Enables support for SANE scanners
        hardware.sane = {
            enable = true;
            extraBackends = [ 
                #nixpkgs.from.stable.sane-airscan
                nixpkgs.from.stable.brscan5 
            ];
            brscan5 = {
                enable = true;
                netDevices = {
                    brother_ads1700w = { model = "ADS-1700W"; ip = "10.48.5.2"; };
                };
            };
            openFirewall = true;
            #netConf = "10.48.6.66";
        };

        # Allow discovery of Canon scanners 
        # Discovery of Canon scanners works via multicast. 
        # SANE sends BJNP discovery messages from all local addresses to ff02::1, UDP port 8612. 
        # Scanners receiving the message respond via unicast UDP.
        #networking.firewall = {
        #    allowedUDPPorts = [ 8610 8612 ]; 
        #};

        services.udev.packages = [ 
            nixpkgs.from.stable.brscan5 
        ];

        services.udev.extraRules = ''
            # Brother ADS-1700W - brscan5
            ATTRS{idVendor}=="04f9", ATTRS{idProduct}=="60e0", MODE="0664", GROUP="scanner", ENV{libsane_matched}="yes"
        '';

        # https://wiki.debian.org/SaneOverNetwork#Canon_Multi-Function__Printers__and_CanonScan_Scanners_via_the_Network
        #environment.etc."sane.d/pixma.conf".text = ''
        #    bjnp://10.48.6.66 
        #'';

        # add brother ads1700w 
        environment.etc."sane.d/net.conf".text = ''
            10.48.5.2
        '';

        # Enable wireless scanning via airscan
        environment.systemPackages = [
            ## Backends
            #nixpkgs.from.stable.sane-airscan    # Scanner Access Now Easy - Apple AirScan (eSCL) driver
            #nixpkgs.from.stable.sane-backends   # SANE backends: includes sane-pixma for Canon i-Sensys MFC645c scanning
            nixpkgs.from.stable.brscan5         # Brother brscan5 sane backend driver
            #nixpkgs.from.stable.dsseries

            ## Frontends
            nixpkgs.from.stable.simple-scan
        ];
    };
}