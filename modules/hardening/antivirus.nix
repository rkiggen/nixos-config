# /hardening/antivirus: antivirus configuration
{ inputs, pkgs, nixpkgs, userName, ... }: {
    config = {

        environment.systemPackages = [
            nixpkgs.from.stable.clamav              # antivirus engine designed for detecting Trojans, viruses, malware and other malicious threats
            nixpkgs.from.stable.clamtk              # easy to use, lightweight front-end for ClamAV (Clam Antivirus)
        ];

        # enable antivirus clamav and
        # keep the signatures' database updated
        services.clamav.daemon.enable = true;
        services.clamav.updater.enable = true; 
   };
}