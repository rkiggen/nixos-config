# wireguard setup
# link: https://joshbuker.com/blog/how-to-use-wireguard-on-nixos-with-gnome/
{ inputs, pkgs, nixpkgs, ... }: {

    config = {
        
        environment.systemPackages = [
            nixpkgs.from.stable.wireguard-tools     # wireguard tools
        ];

        # Allow wireguard connections through firewall
        networking.firewall.checkReversePath = "loose";
    };
}