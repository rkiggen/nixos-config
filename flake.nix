{
    description = "Rob's NixOS System Configurations";

    inputs = {
        # Nix library functions
        nixpgks-for-lib.url = "github:nixos/nixpkgs/nixos-25.11";

        # NixOS
        nixpkgs-for-nixos-l231028a.url = "github:nixos/nixpkgs/nixos-24.05";
        nixpkgs-for-nixos-l241214a.url = "github:nixos/nixpkgs/nixos-25.11";

        # Stable, general purpose
        nixpkgs-from-stable-l231028a.url = "github:nixos/nixpkgs/nixos-24.05";
        nixpkgs-from-stable-l241214a.url = "github:nixos/nixpkgs/nixos-25.11";

        # Unstable, general purpose
        nixpkgs-from-unstable-l231028a.url = "github:nixos/nixpkgs/nixos-unstable";
        nixpkgs-from-unstable-l241214a.url = "github:nixos/nixpkgs/nixos-unstable";

        # Rider
        #nixpkgs-for-rider-l211008a.url = "https://github.com/NixOS/nixpkgs/archive/64c27498901....tar.gz"; # Rider 22.3.2 (unstable channel)
        nixpkgs-for-rider-l231028a.url = "github:nixos/nixpkgs/nixos-24.05"; # Rider 2023.1.2
        nixpkgs-for-rider-l241214a.url = "github:nixos/nixpkgs/nixos-25.11"; 

        # Hardware modules (for Framework specific modules)
        nixos-hardware.url = "github:nixos/nixos-hardware/master";
    };

    outputs = inputs: {
        # `nixosConfigurations.<hostname>` is the output schema used by
        # `nixos-rebuild switch --flake .#<hostname>`.
        # Each attribute can be assigned the attribute set produced
        # by `nixpkgs.lib.nixosSystem`. (see below)

        # `nixpkgs.lib.nixosSystem` handles packages + settings,
        # and guarantees that the result produces a valid operating system.

        # nixosMachine flow courtesy of Stel @ stelcodes! :3
        # This is a parameterized wrapper around `nixpkgs.lib.nixosSystem`.
        nixosConfigurations = 
            let
                nixosMachine = {  system, hostName, userName }:
                    let
                        inherit (inputs."nixpkgs-for-lib".legacyPackages.x86_64-linux) lib;

                        nixpkgsConfig = {
                            inherit system;
                            config.allowUnfree = true;
                        };

                        nixpkgs.for = {
                            rider = import inputs."nixpkgs-for-rider-${hostName}" nixpkgsConfig;
                        };

                        nixpkgs.from = {
                            stable = import inputs."nixpkgs-from-stable-${hostName}" nixpkgsConfig;
                            unstable = import inputs."nixpkgs-from-unstable-${hostName}" nixpkgsConfig;
                        };
                    in
                        inputs."nixpkgs-for-nixos-${hostName}".lib.nixosSystem {
                            inherit system;
                            # inputs relayed to each module
                            specialArgs = { inherit inputs nixpkgs userName hostName; };
                            # files containing actual OS configurations
                            modules = [
                                ./modules/common.nix
                                ./hosts/${hostName}
                            ];
                        };
        in 
        {

            # Clevo NS55 laptop
            l231028a = nixosMachine {
                hostname = "l231028a";
                userName = "rkiggen";
                system = "x86_64-linux";
            };

            # Framework 16 laptop
            l241214a = nixosMachine {
                hostName = "l241214a";
                userName = "rkiggen";
                system = "x86_64-linux";
            };

        };
    };
}
