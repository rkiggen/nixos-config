
# Security configuration
# links:
# - https://nixos.wiki/wiki/Security
# - https://xeiaso.net/blog/paranoid-nixos-2021-07-18/
# - https://dataswamp.org/~solene/2022-01-13-nixos-hardened.html

{ inputs, pkgs, nixpkgs, userName, ... }: {
    config = {

        environment.systemPackages = [
            nixpkgs.from.stable.clamv               # antivirus engine designed for detecting Trojans, viruses, malware and other malicious threats
            nixpkgs.from.stable.clamtk              # easy to use, lightweight front-end for ClamAV (Clam Antivirus)
        ];

        # enable firewall and block all ports
        networking.firewall.enable = true;
        //networking.firewall.allowedTCPPorts = [];
        //networking.firewall.allowedUDPPorts = []; 

        # enable antivirus clamav and
        # keep the signatures' database updated
        services.clamav.daemon.enable = true;
        services.clamav.updater.enable = true; 
   };
}