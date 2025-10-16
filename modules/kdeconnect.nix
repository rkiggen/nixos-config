# kdeconnect setup for xfce (gtk)
# kdeconnect alternatives: gsconnect, valent
{ inputs, pkgs, nixpkgs, ... }: {

    config = {
        
        environment.systemPackages = [
            nixpkgs.from.stable.valent   # Implementation of the KDE Connect protocol, built on GNOME platform libraries
        ];

        # Allow kde connections through firewall
        networking.firewall.allowedTCPPortRanges = [ { from = 1714; to = 1764; } ];
        networking.firewall.allowedUDPPortRanges = [ { from = 1714; to = 1764; } ];
    };
}