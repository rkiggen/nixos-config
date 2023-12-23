{
  description = "My multi host / multi profile NixOS configuration";

  inputs = { 							
	
    # Nix library functions
    nixpkgs-for-lib.url = "github:NixOS/nixpkgs/nixos-23.11";

    # NixOS
    nixpkgs-for-nixos-l211008a.url = "github:nixos/nixpkgs/nixos-23.05";
    nixpkgs-for-nixos-l231028a.url = "github:nixos/nixpkgs/nixos-23.11";

    # Stable, general purpose
    nixpkgs-from-stable-l211008a.url = "github:NixOS/nixpkgs/nixos-23.05";
    nixpkgs-from-stable-l231028a.url = "github:NixOS/nixpkgs/nixos-23.11";

    # Unstable, general purpose
    nixpkgs-from-unstable-l211008a.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-from-unstable-l231028a.url = "github:nixos/nixpkgs/nixos-unstable";

    # Rider 
    nixpkgs-for-rider-l211008a.url = "github:nixos/nixpkgs/nixos-23.05"; # Rider 2023.1.2
    #nixpkgs-for-rider-l211008a.url = "https://github.com/NixOS/nixpkgs/archive/64c27498901f104a11df646278c4e5c9f4d642db.tar.gz"; # Rider 22.3.2 (unstable channel)
    nixpkgs-for-rider-l231028a.url = "github:nixos/nixpkgs/nixos-23.11"; # Rider 2023.1.2

    # Home-manager
    home-manager-l211008a.url = "github:nix-community/home-manager/release-23.05";
    home-manager-l231028a.url = "github:nix-community/home-manager/release-23.11";

  };


  outputs = inputs:
    let
      system = "x86_64-linux";
      inherit (inputs."nixpkgs-for-lib".legacyPackages.x86_64-linux) lib;
      nixpkgsConfig = {
        inherit system;
	config.allowUnfree = true;
      };

      mkNixos = hostname:
        let
	  home-manager = inputs."home-manager-${hostname}";
	  nixpkgs.for = {
	    rider = import inputs."nixpkgs-for-rider-${hostname}" nixpkgsConfig;
	  };
	  nixpkgs.from = {
	    stable = import inputs."nixpkgs-from-stable-${hostname}" nixpkgsConfig;
	    unstable = import inputs."nixpkgs-from-unstable-{hostname}" nixpkgsConfig;
	  };
        in inputs."nixpkgs-for-nixos-${hostname}".lib.nixosSystem {
	  inherit system;
	  specialArgs = { inherit home-manager; };
	  modules = [
	    ./hosts/${hostname}
	    home-manager.nixosModule 
	    {
	      home-manager = {
	        extraSpecialArgs = { inherit nixpkgs; };
		users.rkiggen = {
		  imports = [ ./profiles/rkiggen/${hostname}.nix ];
		};
	      };
	    }
	  ];
	};
      
      in {
        nixosConfigurations = {
	  l211008a = mkNixos "l211008a";
          l231028a = mkNixos "l231028a";
	};
      };
}
