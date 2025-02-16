{
  description = "NixOS System Configuration";

  inputs = {
    # If you want to use the latest upstream version, I recommend using
    # branch "nixos-unstable" instead of "24.11" (the latest stable release)
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
  };

  outputs = { self, nixpkgs }: {
    nixosConfigurations = {
        # This should correspond to the hostname of the machine
	l241214a = nixpkgs.lib.nixosSystem {
	    system = "x86_64-linux";
	    modules = [
	        ./host.nix
		./nix.nix
		./users.nix
		./xfce.nix
		./hardware-configuration.nix
	    ];
	};
    };
  };
}
