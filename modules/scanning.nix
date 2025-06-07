# Setup scanning via SANE 
# https://nixos.wiki/wiki/Scanners

{ pkgs, nixpkgs, ... }: {

    config = {

        # Don't forget to add your user to the scanner & lp groups!!!

        # Enables support for SANE scanners
        hardware.sane = {
            enable = true;
            extraBackends = [ 
                nixpkgs.from.stable.sane-airscan
                nixpkgs.from.stable.brscan5 
            ];
            brscan5 = {
                enable = true;
                netDevices = {
                    brother_ads1700w = { model = "ADS-1700W"; ip = "10.48.5.2"; };
                };
            };
            openFirewall = true;
            netConf = "10.48.6.66";
        };

        # Allow discovery of Canon scanners 
        # Discovery of Canon scanners works via multicast. 
        # SANE sends BJNP discovery messages from all local addresses to ff02::1, UDP port 8612. 
        # Scanners receiving the message respond via unicast UDP.
        networking.firewall = {
            allowedUDPPorts = [ 8612 ];
        };

        services.udev.packages = [ 
            nixpkgs.from.stable.sane-airscan 
            nixpkgs.from.stable.brscan5 
        ];

        #environment.etc."sane.d/airscan.conf".text = ''
        #    [devices]
        #    Canon@Home = http://10.48.6.66:443/eSCL/, eSCL
        #'';

        # Enable wireless scanning via airscan
        environment.systemPackages = [
            ## Backends
            nixpkgs.from.stable.sane-airscan    # Scanner Access Now Easy - Apple AirScan (eSCL) driver
            nixpkgs.from.stable.brscan5         # Brother brscan5 sane backend driver
            nixpkgs.from.stable.dsseries

            ## Frontends
            nixpkgs.from.stable.simple-scan
        ];
    };
}