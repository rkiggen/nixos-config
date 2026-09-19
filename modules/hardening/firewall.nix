# hardening/firewall: Firewall configuration
{ inputs, pkgs, nixpkgs, userName, ... }: {
    config = {

        # enable firewall and block all ports
        networking.firewall.enable = true;
        #networking.firewall.allowedTCPPorts = [];
        #networking.firewall.allowedUDPPorts = []; 

  };
}