# Setup scanning via SANE 
# https://nixos.wiki/wiki/Scanners

{ pkgs, nixpkgs, ... }: {

    config = {

        # Don't forget to add your user to the scanner & lp groups!!!
        
        # Enables support for SANE scanners
        hardware.sane.enable = true; 
        
        # Enable wireless scanning via airscan
        environment.systemPackages = [
            nixpkgs.from.stable.sane-airscan    # Scanner Access Now Easy - Apple AirScan (eSCL) driver
        ];
    };
}