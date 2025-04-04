{
  description = "Rob's NixOS System Configurations";

  inputs = {
    # Nix library functions
    nixpgks-for-lib.url = "github:nixos/nixpkgs/nixos-24.11";
	
    # NixOS
    nixpkgs-for-nixos-l231028a.url = "github:nixos/nixpkgs/nixos-24.05";
    nixpkgs-for-nixos-l241214a.url = "github:nixos/nixpkgs/nixos-24.11";

    # Stable, general purpose
    nixpkgs-from-stable-l231028a.url = "github:nixos/nixpkgs/nixos-24.05";
    nixpkgs-from-stable-l241214a.url = "github:nixos/nixpkgs/nixos-24.11";
    
    # Unstable, general purpose
    nixpkgs-from-unstable-l231028a.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-from-unstable-l241214a.url = "github:nixos/nixpkgs/nixos-unstable";

    # Rider
    #nixpkgs-for-rider-l211008a.url = "https://github.com/NixOS/nixpkgs/archive/64c27498901....tar.gz"; # Rider 22.3.2 (unstable channel)
    nixpkgs-for-rider-l231028a.url = "github:nixos/nixpkgs/nixos-24.05"; # Rider 2023.1.2
    nixpkgs-for-rider-l241214a.url = "github:nixos/nixpkgs/nixos-24.11"; 


    # Home-manager
    home-manager.l231028a.url = "github:nix-community/home-manager/release-24.05";
    home-manager.l241214a.url = "github:nix-community/home-manager/release-24.11";
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
	    doublecmd = import inputs."nixpkgs-for-doublecmd-${hostname}" nixpkgsConfig;
	  };
	  nixpkgs.from = {
	    stable = import inputs."nixpkgs-from-stable-${hostname}" nixpkgsConfig;
	    unstable = import inputs."nixpkgs-from-unstable-${hostname}" nixpkgsConfig;
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
          l231028a = mkNixos "l231028a";
          l241214a = mkNixos "l241214a";
	};
      };

}
